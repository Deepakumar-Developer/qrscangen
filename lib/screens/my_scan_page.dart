import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner/functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class MyScanPage extends StatefulWidget {
  const MyScanPage({super.key});

  @override
  State<MyScanPage> createState() => _MyScanPageState();
}

class _MyScanPageState extends State<MyScanPage> {
  bool showQR = false;
  bool qrLoader = true;
  String? linkText;
  Uint8List? qrImage;
  bool onDetect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 1500), (timer) {
      setState(() {
        qrLoader = !qrLoader;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: colorBackGround,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Scan QR',
                style: GoogleFonts.acme(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                )),
              ),
              Align(
                alignment: const Alignment(0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.height * 0.35,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: MobileScanner(
                              controller: MobileScannerController(
                                  detectionSpeed: DetectionSpeed.noDuplicates,
                                  returnImage: true),
                              onDetect: (capture) async {
                                if (!showQR) {
                                  final List<Barcode> barCodes =
                                      capture.barcodes;
                                  final Uint8List? image = capture.image;
                                  if (image != null) {
                                    setState(() {
                                      onDetect = true;
                                    });
                                    Vibration.vibrate(duration: 500);
                                    var timer = Timer.periodic(
                                        Duration(milliseconds: 500), (timer) {
                                      setState(() {
                                        qrImage = image;
                                        linkText = barCodes.first.rawValue;
                                        showQR = true;
                                      });
                                      timer.cancel();
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                          AnimatedAlign(
                            alignment:
                                qrLoader ? Alignment(0, 1) : Alignment(0, -1),
                            duration: Duration(milliseconds: 1000),
                            child: Divider(
                              color: Colors.black54,
                              thickness: 3,
                            ),
                            curve: Curves.easeInOutSine,
                          ),
                          Align(
                            alignment: Alignment(1, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 3,
                              width: 80,
                            ),
                          ),
                          Align(
                            alignment: Alignment(-1, -1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 3,
                              width: 80,
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, -1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 3,
                              width: 80,
                            ),
                          ),
                          Align(
                            alignment: Alignment(-1, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 3,
                              width: 80,
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 80,
                              width: 3,
                            ),
                          ),
                          Align(
                            alignment: Alignment(1, -1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 80,
                              width: 3,
                            ),
                          ),
                          Align(
                            alignment: Alignment(-1, 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 80,
                              width: 3,
                            ),
                          ),
                          Align(
                            alignment: Alignment(-1, -1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: onDetect ? Colors.green : Colors.black87,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 80,
                              width: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Place the QR here',
                      style: GoogleFonts.acme(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.5,
                        color: Theme.of(context).primaryColor,
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
        if (showQR)
          GestureDetector(
            onTap: () {
              setState(() {
                showQR = false;
                onDetect = false;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black26,
            ),
          ),
        if (showQR)
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  linkText ?? '',
                  style: TextStyle(color: colorBackGround),
                ),
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Image(
                    fit: BoxFit.cover,
                    image: MemoryImage(qrImage!),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (linkText!.toLowerCase().contains('http')) {
                      _launchURL(linkText!);
                    } else if (linkText!.toLowerCase().contains('www')) {
                      try {
                        _launchURL('https://${linkText!}');
                      } catch (e) {
                        _launchURL('http://${linkText!}');
                      }
                    } else {
                      Clipboard.setData(ClipboardData(text: linkText ?? ''));
                      Fluttertoast.showToast(
                          msg: "Text Copied",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: colorBackGround,
                          fontSize: 16.0);
                    }
                  },
                  child: Text(
                    (linkText!.toLowerCase().contains('http') ||
                            linkText!.toLowerCase().contains('www'))
                        ? 'Open Link'
                        : 'copy text',
                    style: GoogleFonts.acme(
                        textStyle:
                            TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
  }
}
