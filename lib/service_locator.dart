import 'package:get_it/get_it.dart';
import 'package:zreader/database.dart';
import 'package:zreader/repositories/local_file.dart';
import 'package:zreader/services/book.dart';
import 'package:zreader/services/chapter.dart';

GetIt locator = GetIt.asNewInstance();

Future<void> setupLocator() async {
  locator.registerSingletonAsync<AppDatabase>(() async {
    final builder = $FloorAppDatabase.databaseBuilder('zreader.db');
    return await builder.build();
  });
  locator.registerSingletonWithDependencies(() {
    return BookService(locator<AppDatabase>().bookRepository);
  }, dependsOn: [AppDatabase]);
  locator.registerSingletonWithDependencies(() {
    return ChapterService(locator<AppDatabase>().chapterRepository);
  }, dependsOn: [AppDatabase]);
  locator.registerSingleton(LocalFileRepository());
  await locator.allReady();
}