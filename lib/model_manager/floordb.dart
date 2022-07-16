import 'package:clicker_app/model/result.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'floordb.g.dart';

@entity
class FlResult {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String _playerName;
  final int _score;

  FlResult(this.id, this._playerName, this._score);
  FlResult.fromResult(Result res)
      : _playerName = res.playerName,
        _score = res.score;

  Result get result => Result(playerName: _playerName, score: _score);
}

@dao
abstract class ResultDao {
  @Query('SELECT * FROM FlResult')
  Future<List<FlResult>> findAllResults();

  @insert
  Future<void> insertResult(FlResult result);
}

@Database(version: 1, entities: [FlResult])
abstract class AppDatabase extends FloorDatabase {
  ResultDao get resultDao;
}
