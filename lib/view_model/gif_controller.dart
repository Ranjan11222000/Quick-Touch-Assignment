import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_touch/data/response/status.dart';
import '../data/Network/network_api_service.dart';
import '../model/gif_model.dart';
import '../res/utils/utils.dart';

class GifController extends GetxController {
  final gifSearch = TextEditingController();
  String apiUrl = "api.giphy.com/v1/gifs/trending";
  String apiKey = "AGwYXRJrUl75Ms2ry7NwSFaRF2pBTnIJ";
  final _apiServices = NetworkApiService();
  List gifList = <Data>[];
  List filterList = <Data>[];
  final rxStatus = Status.LOADING.obs;
  final respMsg = "".obs;

  void setRxtStatus(Status value) => rxStatus.value = value;

  void getGifApi() async {
    setRxtStatus(Status.LOADING);
    getGif().then(
      (value) {
        setRxtStatus(Status.COMPLETED);
        if (value.meta?.status == 200) {
          gifList = value.data ?? [];
          gifList.sort((a, b) => DateTime.parse(b.trendingDatetime)
              .compareTo(DateTime.parse(a.trendingDatetime)));
          filterList = gifList;
        } else {
          respMsg.value = value.meta?.msg ?? "";
          Utils.errorSnackBar("Error", value.meta?.msg ?? "");
        }
      },
    ).onError(
      (error, stackTrace) {
        respMsg.value = error.toString();
        setRxtStatus(Status.ERROR);
        Utils.errorSnackBar("Error", error.toString());
      },
    );
  }

  void searchingGif(String searchText) {
    if (searchText.isEmpty) {
      filterList = gifList;
    } else {
      filterList = gifList
          .where((gif) => (gif.username ?? "").startsWith(searchText))
          .toList();
    }
  }

  Future<GifModel> getGif() async {
    Map<String, dynamic> query = {"api_key": apiKey};
    dynamic response =
        await _apiServices.getApiResponseWithQuery(apiUrl, query);
    return GifModel.fromJson(response);
  }
}
