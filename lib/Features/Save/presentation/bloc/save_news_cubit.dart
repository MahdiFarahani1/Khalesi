import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalesi/Config/setup.dart';
import 'package:khalesi/Features/Save/data/dataBase/model_database.dart';

part 'save_news_state.dart';

class SaveNewsCubit extends Cubit<SaveNewsState> {
  SaveNewsCubit()
      : super(SaveNewsState(
            savedItem: saveModel.values.toList() as List<ModelDataBase>));

  loadSave(BuildContext context) async {
    List data = saveModel.values.toList();
    emit(SaveNewsState(savedItem: data as List<ModelDataBase>));
  }
}
