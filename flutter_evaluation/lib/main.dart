import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_evaluation/provider/articles_provider.dart';
import 'package:flutter_evaluation/provider/search_provider.dart';
import 'package:flutter_evaluation/screens/home.dart';
import 'package:flutter_evaluation/utils/app_constants.dart';
import 'package:provider/provider.dart';
import 'Database/database_helper.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ArticlesProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: Home(),
      ),
    );
  }
}
