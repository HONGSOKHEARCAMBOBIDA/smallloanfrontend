import 'package:get/get.dart';
import 'package:loanfrontend/module/auth/binding/authbinding.dart';
import 'package:loanfrontend/module/auth/view/loginview.dart';
import 'package:loanfrontend/module/client/clientbinding/clientbinding.dart';
import 'package:loanfrontend/module/client/clientview/clientview.dart';
import 'package:loanfrontend/module/client/clientview/createclientview.dart';
import 'package:loanfrontend/module/communce/communcebinding/communcebinding.dart';
import 'package:loanfrontend/module/district/districtbinding/districtbinding.dart';
import 'package:loanfrontend/module/main/binding/mainbinding.dart';
import 'package:loanfrontend/module/main/mainmiddleware/mainmiddleware.dart';
import 'package:loanfrontend/module/main/mainview/mainview.dart';
import 'package:loanfrontend/module/province/provincebinding/provincebinding.dart';
import 'package:loanfrontend/module/village/villagebinding/villagebinding.dart';
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
      ),
    GetPage(
      name: '/createclient', 
      page: ()=>Createclientview(),
      bindings: [
        Clientbinding(),
        Provincebinding(),
        Districtbinding(),
        Communcebinding(),
        Villagebinding(),
      ]
      ),
    GetPage(
      name: '/listclient', 
      page: ()=>Clientview(),
      binding: Clientbinding()
      )

      
   ];
}