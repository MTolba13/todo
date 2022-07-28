import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/components/components.dart';
import 'package:todo/logic/cubit/cubit.dart';
import 'package:todo/logic/cubit/states.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var completedTasks = AppCubit.get(context).completedTasks;
        return taskBuilder(tasks: completedTasks);
      },
    );
  }
}
