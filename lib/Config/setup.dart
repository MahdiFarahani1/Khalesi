import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:khalesi/Features/Save/data/dataBase/model_database.dart';

late Box saveAll;
late Box saveModel;
setUp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  saveAll = await Hive.openBox("saveAll");

  Hive.registerAdapter(ModelDataBaseAdapter());
  saveModel = await Hive.openBox<ModelDataBase>("saveModel");
}
