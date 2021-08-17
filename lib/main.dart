import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/screens/mainPage.dart';
import 'package:path_provider/path_provider.dart';

import 'models/movieModel.dart';

const String movieBoxName = "movieList";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MovieItemAdapter());
  await Hive.openBox<MovieItem>(movieBoxName);
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    title: "Movie App",
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}
