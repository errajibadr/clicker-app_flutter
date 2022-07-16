import 'package:clicker_app/model/result.dart';
import 'package:clicker_app/model_manager/localdata_modelmanager.dart';

class ResultManager {
  Result? currentRes;
  List<Result> previousgames = [];

  Future<List<Result>> getdata() async {
    previousgames = await LocalDataModelManager.getLocalData();
    print('resultManager getdata is called ');
    return previousgames;
  }

  isGameinProgress() {
    final game = currentRes;
    return game != null && game.isRunningScore;
  }

  startGame(String username) {
    currentRes = Result(playerName: username);
    currentRes?.startGame();
  }

  endGame() {
    final game = currentRes;
    if (game != null) {
      game.endGame();
      print(previousgames);
      previousgames.add(game);
      print(previousgames);
      LocalDataModelManager.addResult(game);
    }
  }
}
