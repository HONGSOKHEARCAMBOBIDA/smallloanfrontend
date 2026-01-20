import 'package:get/get.dart';
import 'package:loanfrontend/module/auth/binding/authbinding.dart';
import 'package:loanfrontend/module/auth/view/loginview.dart';
import 'package:loanfrontend/module/main/binding/mainbinding.dart';
import 'package:loanfrontend/module/main/mainmiddleware/mainmiddleware.dart';
import 'package:loanfrontend/module/main/mainview/mainview.dart';
class AppPage {
   static const INITIAL = '/main';
   static final routes = [
    GetPage(
      name: '/main', 
      middlewares: [MainMiddleware()],
      page: ()=>MainView(),
      bindings: [MainBinding(),]
      ),
    GetPage(
      name: '/login', 
      page: ()=>LoginView(),
      binding: Authbinding()
      )
      
   ];
}