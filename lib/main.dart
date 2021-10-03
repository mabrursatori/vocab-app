import 'package:flutter/material.dart';
import 'package:vocab_app/model/monster.dart';
import 'package:vocab_app/model/vocab.dart';
import 'package:vocab_app/view/dashboard_page.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentaryDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentaryDirectory.path);
  Hive.registerAdapter(MonsterAdapter());
  Hive.registerAdapter(VocabAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
