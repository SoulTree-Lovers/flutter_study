import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:section30_dust/model/stat_model.dart';
import 'package:section30_dust/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [StatModelSchema],
    directory: dir.path,
  );

  GetIt.I.registerSingleton<Isar>(isar);

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Sunflower',
      ),
      home: HomeScreen(),
    ),
  );
}