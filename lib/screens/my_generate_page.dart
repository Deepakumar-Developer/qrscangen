import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:scanner/functions.dart';

class MyGeneratePage extends StatefulWidget {
  const MyGeneratePage({super.key});

  @override
  State<MyGeneratePage> createState() => _MyGeneratePageState();
}

class _MyGeneratePageState extends State<MyGeneratePage> {
  final _qrLink = TextEditingController();
  String? qrLink;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: colorBackGround,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            'Generate QR',
            style: GoogleFonts.acme(
                textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.75),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _qrLink,
              cursorColor: colorBackGround,
              onSubmitted: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    qrLink = value;
                  }
                });
              },
              style: TextStyle(color: colorBackGround),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '  Give the value to QR ',
                  hintStyle: GoogleFonts.acme(
                      textStyle: TextStyle(color: colorBackGround))),
            ),
          ),
          Expanded(
              child: Center(
            child: SizedBox(
              child: (qrLink != null)
                  ? Container(
                      height: 250,
                      width: 250,
                      margin: const EdgeInsets.all(20),
                      child: PrettyQrView.data(data: qrLink!),
                    )
                  : Container(),
            ),
          ))
        ],
      ),
    );
  }
}
