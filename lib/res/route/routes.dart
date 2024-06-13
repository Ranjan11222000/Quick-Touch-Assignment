import 'package:get/get.dart';
import '../../view/gif_view.dart';
class AppRoutes{
  static appRoutes()=>[
    GetPage(name: "LoginPage", page:()=> const GifView(),
    transition: Transition.leftToRightWithFade),
  ];
}