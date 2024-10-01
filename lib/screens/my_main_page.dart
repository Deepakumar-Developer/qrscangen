import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanner/functions.dart';
import 'package:scanner/screens/my_generate_page.dart';
import 'package:scanner/screens/my_scan_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  int index = 0;
  List<Widget> bodyWidget = const [MyScanPage(), MyGeneratePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          index == 0 ? 'QR Scanner' : 'QR Generator',
          style: GoogleFonts.acme(),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                index = 0;
              });
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(Icons.document_scanner),
                AnimatedAlign(
                    alignment: index == 0
                        ? const Alignment(1, 1)
                        : const Alignment(-1, -1),
                    curve: Curves.easeInOutExpo,
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      index == 0 ? '------' : '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, letterSpacing: -2),
                    ))
              ],
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                index = 1;
              });
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(Icons.adf_scanner),
                AnimatedAlign(
                    alignment: index == 1
                        ? const Alignment(1, 1)
                        : const Alignment(-1, -1),
                    curve: Curves.easeInOutExpo,
                    duration: const Duration(milliseconds: 750),
                    child: Text(
                      index == 1 ? '------' : '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, letterSpacing: -2),
                    ))
              ],
            ),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
      body: bodyWidget[index],
    );
  }

  Future<void> _launchURL(String url) async {
    await launchUrl(Uri.parse(url));
    Fluttertoast.showToast(
        msg: "Link Open",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: colorBackGround,
        fontSize: 16.0);
  }
}
