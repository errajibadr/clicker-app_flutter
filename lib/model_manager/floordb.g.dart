// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floordb.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  // ignore: library_private_types_in_public_api
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ResultDao? _resultDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FlResult` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `_playerName` TEXT NOT NULL, `_score` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ResultDao get resultDao {
    return _resultDaoInstance ??= _$ResultDao(database, changeListener);
  }
}

class _$ResultDao extends ResultDao {
  _$ResultDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _flResultInsertionAdapter = InsertionAdapter(
            database,
            'FlResult',
            (FlResult item) => <String, Object?>{
                  'id': item.id,
                  '_playerName': item._playerName,
                  '_score': item._score
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FlResult> _flResultInsertionAdapter;

  @override
  Future<List<FlResult>> findAllResults() async {
    //await _queryAdapter.queryNoReturn('SELECT * FROM FlResult');
    return _queryAdapter.queryList('SELECT * FROM FlResult',
        mapper: (Map<String, Object?> row) => FlResult(row['id'] as int?,
            row['_playerName'] as String, row['_score'] as int));
  }

  @override
  Future<void> insertResult(FlResult result) async {
    await _flResultInsertionAdapter.insert(result, OnConflictStrategy.abort);
  }
}
