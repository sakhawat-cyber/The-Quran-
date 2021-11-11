import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_holy_quran/darkModeControlar/darkThemeProvider.dart';
import 'package:the_holy_quran/darkModeControlar/themeStyle.dart';
import 'package:the_holy_quran/view/HomeScreen.dart';
import 'package:the_holy_quran/view/otherViews/introduction.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    darkThemeProvider.darkTheme =
        await darkThemeProvider.darkThemePref.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider(create: (_) {
      return darkThemeProvider;
    }, child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return MaterialApp(
        title: "They Holy Qur'an",
        debugShowCheckedModeBanner: false,
        theme: ThemeStyles.themeData(darkThemeProvider.darkTheme, context),
        home: Builder(
          builder: (context) => HomeScreen(
            maxSlide: MediaQuery.of(context).size.width * 0.835,
          ),
        ),
        initialRoute: initScreen == 0 || initScreen == null
            ? '/introduction'
            : '/HomeScreen',
        routes: <String, WidgetBuilder>{
          '/introduction': (context) => OnBoardingCard(),
          '/HomeScreen': (context) =>
              HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),
        },
      );
    }));
  }
}
