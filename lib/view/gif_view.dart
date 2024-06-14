import 'dart:developer';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/response/status.dart';
import '../res/components/text_editor.dart';
import '../res/components/text_style.dart';
import '../view_model/gif_controller.dart';

class GifView extends StatefulWidget {
  const GifView({super.key});

  @override
  State<GifView> createState() => _GifViewState();
}

class _GifViewState extends State<GifView> {
  final gifController = Get.put(GifController());

  @override
  void initState() {
    gifController.getGifApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("GIF"),
        centerTitle: true,
        titleTextStyle: text6().copyWith(fontSize: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            searchEditText(),
            const SizedBox(
              height: 15,
            ),
            Flexible(child: gifListView())
          ],
        ),
      ),
    );
  }

  Widget searchEditText() {
    return EditText(
      controller: gifController.gifSearch,
      hintText: "Search gif..",
      prefixIcon: Icons.search,
      onChanged: (value) {
        gifController.searchingGif(value.toString());
        setState(() {});
        return null;
      },
    );
  }

  gifListView() {
    return Obx(() {
      switch (gifController.rxStatus.value) {
        case Status.LOADING:
          return const CircularProgressIndicator();
        case Status.ERROR:
          return const Text("ERROR");
        case Status.COMPLETED:
          return gifController.filterList.isEmpty
              ? const Text("NO GIF")
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.network(
                          fit:BoxFit.fill,
                          gifController.filterList[index].images?.original?.url ??
                              "",
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Text("Failed to load image"));
                          },
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: Obx(
                          ()=> FavoriteButton(
                              isFavorite: gifController.gifFav.value,
                              valueChanged: (isFavorite) {
                                log('Is Favorite : $isFavorite');
                                gifController.gifFav.value= isFavorite;
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: gifController.filterList.length,
                );
      }
    });
  }
}
