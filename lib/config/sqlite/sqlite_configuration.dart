import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:vaden/vaden.dart';

@Configuration()
class SqliteConfiguration {
  @Bean()
  Database sqliteDatabase(ApplicationSettings settings) {
    final databasePath = settings['sqlite']['database_path'];
    final createIfMissing = settings['sqlite']['create_if_missing'] == 'true';
    
    // Create database directory if it doesn't exist
    final dbFile = File(databasePath);
    if (!dbFile.existsSync() && createIfMissing) {
      dbFile.parent.createSync(recursive: true);
    }
    
    // Open the database
    return sqlite3.open(databasePath);
  }
  
  void closeDatabase(Database database) {
    database.dispose();
  }
}
