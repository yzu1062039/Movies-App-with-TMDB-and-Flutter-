import 'package:movie_tmdb/data/models/movie_detail/movie_detail_model.dart';
import 'package:movie_tmdb/domain/entities/export_entities.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String fileName = "movie_db.db";

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._constructor();
  static Database? _db;

  LocalDatabase._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  final String _tableName = "movies_detail";
  final String _id = "id";
  final String _originalTitle = "original_title";
  final String _originalLanguage = "original_language";
  final String _popularity = "popularity";
  final String _adult = "adult";
  final String _backdropPath = "backdrop_path";
  final String _genreIds = "genre_ids";
  final String _overview = "overview";
  final String _posterPath = "poster_path";
  final String _releaseDate = "release_date";
  final String _title = "title";
  final String _video = "video";
  final String _voteAverage = "vote_average";
  final String _voteCount = "vote_count";

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath.toString(), fileName);
    final database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName(
          $_id INTEGER PRIMARY KEY,
          $_popularity REAL NOT NULL,
          $_voteCount INTEGER NOT NULL,
          $_video INTEGER NOT NULL,
          $_posterPath TEXT NOT NULL,
          $_adult INTEGER NOT NULL,
          $_backdropPath TEXT NOT NULL,
          $_originalLanguage TEXT NOT NULL,
          $_originalTitle TEXT NOT NULL,
          $_genreIds BLOB NOT NULL,
          $_title TEXT NOT NULL,
          $_voteAverage REAL NOT NULL,
          $_overview TEXT NOT NULL,
          $_releaseDate TEXT NOT NULL,
          )
          ''');
      },
    );
    return database;
  }

  Future<void> deleteMovieDetail({required int? movieId}) async {
    try {
      final db = await database;
      await db.delete(_tableName, where: 'id=?', whereArgs: [movieId]);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<MovieDetailEntity>> getSavedMovieDetails() async {
    try {
      final db = await database;
      final data = await db.query(_tableName);
      List<MovieDetailEntity> list = [];
      for (var element in data) {
        var movieDetailModel = MovieDetailModel.fromJson(element);
        list.add(movieDetailModel.toEntity());
      }

      return list;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> saveMovieDetail({
    required MovieDetailModel movieDetailModel,
  }) async {
    try {
      final db = await database;
      var data = movieDetailModel.toJson();
      if (data['id'] != null) {
        int video, adult;
        data['video'] ? video = 1 : video = 0;
        data['adult'] ? adult = 1 : adult = 0;

        for (var element in data['genre_ids']) {
          if (element == 10770 || element == "10770") {
            var key = data['genre_ids'].indexOf(10770);
            data['genre_ids'][key] = 19;
            break;
          }
        }

        await db.insert(_tableName, {
          _id: data['id'],
          _popularity: data['popularity'],
          _voteCount: data['vote_count'],
          _video: video,
          _posterPath: data['poster_path'],
          _adult: adult,
          _backdropPath: data['backdrop_path'],
          _originalLanguage: data['original_language'],
          _originalTitle: data['original_title'],
          _genreIds: data['genre_ids'],
          _title: data['title'],
          _voteAverage: data['vote_average'],
          _overview: data['overview'],
          _releaseDate: data['release_date'],
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> isSavedMovieDetail({required int? movieId}) async {
    try {
      final db = await database;
      final List data = await db.query(
        _tableName,
        where: 'id=?',
        whereArgs: [movieId],
      );

      bool isSaved;
      if (data.isEmpty) {
        isSaved = false;
      } else {
        isSaved = true;
      }

      return isSaved;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> close() async {
    final db = await database;
    return db.close();
  }
}
