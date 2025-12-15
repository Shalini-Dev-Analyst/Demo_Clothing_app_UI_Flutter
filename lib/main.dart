import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_apparels_clothes/View%20Models/CategoryScreen/CategoryBoxVM.dart';
import 'package:s_apparels_clothes/View%20Models/CategoryScreen/CategoryScreenVM.dart';
import 'package:s_apparels_clothes/View%20Models/CategoryScreen/Product/BoxAvatarVM.dart';
import 'package:s_apparels_clothes/View%20Models/EliteSpotLightViewModel/EliteSpotlightVM.dart';
import 'package:s_apparels_clothes/View%20Models/PartyReadyViewModel/PartyReadyVM.dart';
import 'package:s_apparels_clothes/View%20Models/PriceDropParadiseViewModel/PriceDropParaDiseVM.dart';
import 'package:s_apparels_clothes/View%20Models/TodaysTopStealsViewModel/TodaysTopStealsVM.dart';
import 'package:s_apparels_clothes/View%20Models/UniqueCollectionsViewModel/UniqueCollectionsCardsVM.dart';
import 'package:s_apparels_clothes/View%20Models/WeddingDairiesViewModel/WeddingDiariesVM.dart';
import 'package:s_apparels_clothes/View%20Models/WinterSpotViewModel/WinterSpotVM.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View Models/AccountScreen/WishlistVM.dart';
import 'View Models/BannerViewModel/bannercaraousalVM.dart';
import 'View Models/BrandsOfferCardViewModel/BrandOffersVM.dart';
import 'View Models/CartListViewModel/CartListVM.dart';
import 'View Models/CategoryScreen/Product/Product_View_Model.dart';
import 'View Models/CuratedExclusivesViewModel/CuratedExclusiveVM.dart';
import 'View Models/SeasonalCardsViewModel/SeasonalCaraousalVM.dart';
import 'View/Splash Screen/splashscreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UniquecollectionscardsVm()),
        ChangeNotifierProvider(create: (_) => TodaystopstealsVM()),
        ChangeNotifierProvider(create: (_) => BannersViewModel()),
        ChangeNotifierProvider(create: (_) => SeasonalCardsViewModel()),
        ChangeNotifierProvider(create: (_) => BrandOfferCardsvm()),
        ChangeNotifierProvider(create: (_) => Winterspotvm()),
        ChangeNotifierProvider(create: (_) => WeddingdiariesVM()),
        ChangeNotifierProvider(create: (_) => CuratedexclusiveVM()),
        ChangeNotifierProvider(create: (_) => PricedropparadiseVM()),
        ChangeNotifierProvider(create: (_) => PartyreadyVM()),
        ChangeNotifierProvider(create: (_) => ElitespotlightVM()),
        ChangeNotifierProvider(create: (_) => CategoryboxVM()),
        ChangeNotifierProvider(create: (_) => BoxAvatarVM()),
        ChangeNotifierProvider(create: (_) => CategoryVM()),
        ChangeNotifierProvider(create: (_) => ProductVM()),
        ChangeNotifierProvider(create: (_) => WishlistVM()),
        ChangeNotifierProvider(create: (_) => Cartlistviewmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool("loggedIn") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return MaterialApp(home: SizedBox());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}


