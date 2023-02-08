import 'package:get_it/get_it.dart';
import 'package:zreader/database.dart';
import 'package:zreader/services/book.dart';

GetIt locator = GetIt.asNewInstance();

Future<void> setupLocator() async {
  locator.registerSingletonAsync<AppDatabase>(() async {
    final builder = $FloorAppDatabase.databaseBuilder('zreader.db');
    return await builder.build();
  });
  locator.registerSingletonAsync(() {
    return Future.value(BookService(locator<AppDatabase>().bookRepository));
  }, dependsOn: [AppDatabase]);
  await locator.allReady();
}