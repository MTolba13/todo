import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/components/components.dart';
import 'package:todo/logic/cubit/states.dart';
import 'package:todo/presentation/layouts/sch_screen.dart';
import 'package:todo/presentation/layouts/add_task_screen.dart';
import 'package:todo/presentation/screens/all_tasks.dart';
import 'package:todo/presentation/screens/completed_tasks.dart';
import 'package:todo/presentation/screens/favourite_task.dart';
import 'package:todo/presentation/screens/uncompleted_tasks.dart';
import 'package:todo/style/themes.dart';

import '../../logic/cubit/cubit.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        return DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Board',
                style: headingStyle,
              ),
              elevation: 1,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    navigateTo(context, const ScheduleScreen());
                  },
                ),
              ],
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                automaticIndicatorColorAdjustment: false,
                dragStartBehavior: DragStartBehavior.start,
                tabs: cubit.tabs,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                indicatorWeight: 3.0,
                physics: const NeverScrollableScrollPhysics(),
                labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: cubit.tabController,
                      children: const [
                        AllTasksScreen(),
                        UncompletedTaskScreen(),
                        CompletedTasksScreen(),
                        FavouriteTaskScreen(),
                      ],
                    ),
                  ),
                  defaultButton(
                    context: context,
                    onClick: () {
                      navigateTo(
                        context,
                        const AddTaskScreen(),
                      );
                    },
                    text: 'Add a task',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
