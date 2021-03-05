// TODO Implement this library.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mywhatsapp/whatsapp_home.dart';


Future<Null> main() async {
  runApp(new FlutteredApp());
}

class FlutteredApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "WhatsApp",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      debugShowCheckedModeBanner: false,
      home: new WhatsAppHome(),
    );
  }
}
