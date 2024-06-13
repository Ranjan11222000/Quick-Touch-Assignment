import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    );
  }
}
