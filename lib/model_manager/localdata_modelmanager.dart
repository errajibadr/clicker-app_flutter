import 'package:clicker_app/model_manager/floordb.dart';

import '../model/result.dart';

class LocalDataModelManager {
  static Future<List<Result>> getLocalData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final resultDao = database.resultDao;
    final results = await resultDao.findAllResults();
    return results.map((e) => e.result).toList();
  }

  static Future<void> addResult(Result res) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final resultDao = database.resultDao;

    resultDao.insertResult(FlResult.fromResult(res));
  }
}
