
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

///
import '../data/hive_data_store.dart';
import '../models/task.dart';
import '../view/home/home_view.dart';

Future<void> main() async {
  
  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter());

  /// Open box
  var box = await Hive.openBox<Task>("tasksBox");

  /// Delete data from previous day
  box.values.forEach((task) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {}
  });

  runApp(BaseWidget(child: const MyApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle( // Equivalent to headline1
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle( // Equivalent to subtitle1
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle( // Equivalent to headline2
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle( // Equivalent to headline3
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineLarge: TextStyle( // Equivalent to headline4
            color: Colors.grey,
            fontSize: 17,
          ),
          headlineMedium: TextStyle( // Equivalent to headline5
            color: Colors.grey,
            fontSize: 16,
          ),
          titleSmall: TextStyle( // Equivalent to subtitle2
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headlineSmall: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),

      ),
      home: const HomeView(),
    );
  }
}
