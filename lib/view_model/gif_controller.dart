import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/Network/network_api_service.dart';
import '../model/gif_model.dart';
import '../res/utils/utils.dart';

class GifController extends GetxController{
  final gifSearch= TextEditingController();
  String apiUrl = "api.giphy.com/v1/gifs/trending";
  String apiKey = "AGwYXRJrUl75Ms2ry7NwSFaRF2pBTnIJ";
  final _apiServices = NetworkApiService();
  final gifList =[].obs;



    getGifApi() async{
      gifList.clear();
      getGif().then((value) {
        if(value.meta?.status==200){
        gifList.add(value.data);
        }else{
         Utils.errorSnackBar("Error", value.meta?.msg??"");
        }
      },).onError((error, stackTrace) {

      },);
    }



  Future<GifModel> getGif() async{

    Map<String,dynamic> query = {
      "api_key":apiKey
    };
    dynamic response =await _apiServices.getApiResponseWithQuery(apiUrl, query);
    return GifModel.fromJson(response);
  }
}