import 'package:flutter/material.dart';
import 'package:wisata_lamongan/screen/detailview.dart';
import 'package:wisata_lamongan/screen/explore.dart';
import 'package:wisata_lamongan/screen/homepage.dart';
import 'package:wisata_lamongan/screen/splashscreen.dart';
import 'package:wisata_lamongan/screen/umkm.dart';
import 'package:wisata_lamongan/screen/wisataalam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TriSum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => HomePage(),
        '/explore': (context) => Explore(),
        '/alam': (context) => WisataAlam(),
        '/umkm': (context) => Umkm(),
        // '/register': (context) => RegisterPage(),
        // '/profile': (context) => ProfilePage(),
        // '/favorite': (context) => FavoritePage(),
      },
    );
  }
}
