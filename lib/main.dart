import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/cubit/cubit.dart';
import 'package:todo/logic/cubit/observer.dart';
import 'package:todo/logic/cubit/states.dart';
import 'package:todo/presentation/layouts/board_screen.dart';
import 'package:todo/style/themes.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.myTheme,
            home: const BoardScreen(),
          );
        },
      ),
    );
  }
}
