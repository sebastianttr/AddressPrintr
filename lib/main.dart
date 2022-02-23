import 'package:address_printr/Layouts/GenerateAddressLayout.dart';
import 'package:address_printr/Layouts/SettingsLayout.dart';
import 'package:address_printr/Modals/MissingAddressModalView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widgets/SelectionItem.dart';
import './Layouts/SettingsLayout.dart';
import './Utils/NotificationOverlayHandler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: const MaterialColor(0xFF64DD17, <int, Color>{
            50: Color(0xFF64DD17), //10%
            100: Color(0xFF64DD17), //20%
            200: Color(0xFF64DD17), //30%
            300: Color(0xFF64DD17), //40%
            400: Color(0xFF64DD17), //50%
            500: Color(0xFF64DD17), //60%
            600: Color(0xFF64DD17), //70%
            700: Color(0xFF64DD17), //80%
            800: Color(0xFF64DD17), //90%
            900: Color(0xFF64DD17), //100%
          }),
          fontFamily: "Product Sans"),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Address Printer'),
        '/generateAddress': (context) => const GenerateAddressLayout(),
        '/settings': (context) => const SettingsLayout()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> getSelectionItems() {
    return [
      const SelectionItem(
          title: "Generate Address",
          description: "Generate a printable sheet with address",
          imgPath: "./assets/images/file.png",
          linksTo: "/generateAddress"),
      const SelectionItem(
          title: "Settings",
          description: "Set your address or configure your print setup",
          imgPath: "./assets/images/settings.png",
          linksTo: "/settings")
    ];
  }

  openMissingInfoDialog() => showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context1) {
        return MissingAddressModalView(context: context);
      });

  void checkPostalInformation() async {
    final storage = await SharedPreferences.getInstance();
    bool hasData = storage.containsKey("postalInformation");
    if (!hasData) {
      openMissingInfoDialog();
    }
  }

  @override
  void initState() {
    super.initState();
    checkPostalInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                pref.remove("postalInformation");
                openMissingInfoDialog();

                //showNotifier(context, "Address set.");
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getSelectionItems()),
      backgroundColor: Colors.white,
    );
  }
}
