import 'package:get/get.dart';
import 'package:loanfrontend/module/auth/binding/authbinding.dart';
import 'package:loanfrontend/module/auth/view/loginview.dart';
import 'package:loanfrontend/module/cashiersession/binding/cashiersessionbinding.dart';
import 'package:loanfrontend/module/cashiersession/view/cashiersessionview.dart';
import 'package:loanfrontend/module/cashiersession/view/createcashiersessionview.dart';
import 'package:loanfrontend/module/chartaccount/binding/chartaccountbinding.dart';
import 'package:loanfrontend/module/client/clientbinding/clientbinding.dart';
import 'package:loanfrontend/module/client/clientview/clientview.dart';
import 'package:loanfrontend/module/client/clientview/createclientview.dart';
import 'package:loanfrontend/module/communce/communcebinding/communcebinding.dart';
import 'package:loanfrontend/module/district/districtbinding/districtbinding.dart';
import 'package:loanfrontend/module/documenttype/bindng/documenttypebinding.dart';
import 'package:loanfrontend/module/journal/binding/journalbinding.dart';
import 'package:loanfrontend/module/journal/view/balanchsheetview.dart';
import 'package:loanfrontend/module/journal/view/createjournalview.dart';
import 'package:loanfrontend/module/journal/view/incomestatementview.dart';
import 'package:loanfrontend/module/journal/view/journalview.dart';
import 'package:loanfrontend/module/journal/view/updatejournalview.dart';
import 'package:loanfrontend/module/loan/binding/loanbinding.dart';
import 'package:loanfrontend/module/loan/view/createloanview.dart';
import 'package:loanfrontend/module/loan/view/lateloanview.dart';
import 'package:loanfrontend/module/loan/view/loanforapprove.dart';
import 'package:loanfrontend/module/loan/view/loanforcheck.dart';
import 'package:loanfrontend/module/loan/view/loanview.dart';
import 'package:loanfrontend/module/loanproduct/binding/loanproductbinding.dart';
import 'package:loanfrontend/module/main/binding/mainbinding.dart';
import 'package:loanfrontend/module/main/mainmiddleware/mainmiddleware.dart';
import 'package:loanfrontend/module/main/mainview/mainview.dart';
import 'package:loanfrontend/module/province/provincebinding/provincebinding.dart';
import 'package:loanfrontend/module/reciept/binding/recieptbinding.dart';
import 'package:loanfrontend/module/reciept/view/recieptlistview.dart';
import 'package:loanfrontend/module/reciept/view/recieptview.dart';
import 'package:loanfrontend/module/role/binding/rolebinding.dart';
import 'package:loanfrontend/module/role/view/roleview.dart';
import 'package:loanfrontend/module/user/binding/userbinding.dart';
import 'package:loanfrontend/module/user/view/createuserview.dart';
import 'package:loanfrontend/module/user/view/userview.dart';
import 'package:loanfrontend/module/village/villagebinding/villagebinding.dart';

class AppPage {
  static const INITIAL = '/main';
  static final routes = [
    GetPage(
      name: '/main',
      middlewares: [MainMiddleware()],
      page: () => MainView(),
      bindings: [MainBinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: Authbinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/createclient',
      page: () => Createclientview(),
      bindings: [
        Clientbinding(),
        Provincebinding(),
        Districtbinding(),
        Communcebinding(),
        Villagebinding(),
      ],
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: '/listclient',
      page: () => const Clientview(),
      binding: Clientbinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/creatloan',
      page: () => Createloanview(),
      bindings: [
        Loanbinding(),
        Loanproductbinding(),
        Clientbinding(),
        Documenttypebinding(),
        Authbinding(),
      ],
      transition: Transition.downToUp,
    ),
    GetPage(
      name: '/checkloan',
      page: () => const Loanforcheck(),
      binding: Loanbinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/approveloan',
      page: () => const Loanforapprove(),
      binding: Loanbinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/viewloan',
      page: () => const Loanview(),
      bindings: [Loanbinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/viewlateloan',
      page: () => const Lateloanview(),
      bindings: [Loanbinding()],
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/creatsession',
      page: () => const Createcashiersessionview(),
      binding: Cashiersessionbinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: '/rollbackcashiersession',
      page: () => const Cashiersessionview(),
      binding: Cashiersessionbinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/viewreciept',
      page: () => const Recieptview(),
      binding: Recieptbinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/viewrecieptlist',
      page: () => const Recieptlistview(),
      bindings: [Recieptbinding(), Authbinding()],
      transition: Transition.fade,
    ),
    GetPage(
      name: '/createjournal',
      page: () => const Createjournalview(),
      bindings: [Journalbinding(), Chartaccountbinding()],
      transition: Transition.downToUp,
    ),
    GetPage(
      name: '/journal',
      page: () => const Journalview(),
      bindings: [Journalbinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/balanchsheet',
      page: () => const BalanceSheetView(),
      bindings: [Journalbinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/incomestament',
      page: () => Incomestatementview(),
      binding: Journalbinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
        name: '/createuser',
        page: () => Createuserview(),
        bindings: [Userbinding(), Rolebinding()]),
    GetPage(name: '/userview', page: () => Userview(), binding: Userbinding()),
    GetPage(name: '/roleview', page: () => Roleview(), binding: Rolebinding())
  ];
}
