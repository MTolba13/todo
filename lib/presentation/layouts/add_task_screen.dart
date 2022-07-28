// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/components.dart';
import 'package:todo/logic/cubit/cubit.dart';
import 'package:todo/logic/cubit/states.dart';
import 'package:todo/presentation/layouts/board_screen.dart';
import 'package:todo/style/themes.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _TaskScreenState();
}

DateTime selectedDate = DateTime.now();
String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

class _TaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppInsertDatabaseSuccessfulState) {
          BlocProvider.of<AppCubit>(context).titleController.clear();
          BlocProvider.of<AppCubit>(context).startTimeController.clear();
          BlocProvider.of<AppCubit>(context).endTimeController.clear();
          BlocProvider.of<AppCubit>(context).dateController.clear();
          BlocProvider.of<AppCubit>(context).remindController.clear();

          navigateAndFinish(context, const BoardScreen());
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 15,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Add task',
              style: subHeadingStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Title',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      hintText: 'write your title..',
                      controller: cubit.titleController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Date',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20.0,
                        end: 10.0,
                      ),
                      hintText: DateFormat.yMd().format(selectedDate),
                      controller: cubit.dateController,
                      keyboardType: TextInputType.datetime,
                      isIcon: true,
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        ).then((value) {
                          if (value != null) {
                            cubit.dateController.text =
                                '${value.day} - ${value.month} - ${value.year}';
                            debugPrint(cubit.dateController.text);
                          }
                        });
                      },
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter deadLine';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Time',
                                style: titleStyle,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              defaultFormField(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 10.0,
                                  ),
                                  hintText: startTime,
                                  controller: cubit.startTimeController,
                                  keyboardType: TextInputType.datetime,
                                  isIcon: true,
                                  icon: const Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Start Time';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        cubit.startTimeController.text =
                                            '${value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
                                        debugPrint(
                                            cubit.startTimeController.text);
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Time',
                                style: titleStyle,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              defaultFormField(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 10.0,
                                ),
                                hintText: '04:00 Pm',
                                controller: cubit.endTimeController,
                                keyboardType: TextInputType.datetime,
                                isIcon: true,
                                icon: const Icon(Icons.access_time,
                                    color: Colors.grey, size: 18.0),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Start Time';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      cubit.endTimeController.text =
                                          '${value.hour > 12 ? value.hour - 12 : value.hour}:${value.minute} ${value.hour > 12 ? 'PM' : 'AM'}';
                                      debugPrint(cubit.endTimeController.text);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Remind',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.only(
                        start: 20.0,
                        end: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: DropdownButtonFormField<dynamic>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                        ),
                        value: cubit.selectedReminderValue,
                        hint: Text(
                          'select',
                          style: titleStyle,
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            cubit.selectedReminderValue = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            cubit.selectedReminderValue = value;
                          });
                        },
                        items: cubit.listOfValue,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Color',
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var i = 0; i < cubit.colors.length; i++)
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                border: cubit.isSelected &&
                                        cubit.colorSelected == cubit.colors[i]
                                    ? Border.all(
                                        color: Colors.white.withOpacity(0),
                                        width: 0.0,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(100.0),
                                color: cubit.colors[i],
                              ),
                              child: IconButton(
                                icon: cubit.isSelected &&
                                        cubit.colorSelected == cubit.colors[i]
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 15,
                                      )
                                    : Container(
                                        color: cubit.colors[i],
                                      ),
                                onPressed: () {
                                  cubit.setColor(cubit.colors[i]);
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 160,
                    ),
                    defaultButton(
                      context: context,
                      text: 'Create a Task',
                      onClick: () {
                        if (cubit.titleController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter a title';
                          return;
                        } else if (cubit.startTimeController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter a start time';
                          return;
                        } else if (cubit.endTimeController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter an end time';
                          return;
                        } else if (cubit.dateController.text.isEmpty) {
                          cubit.errorMessage = 'Please enter a deadline';
                          return;
                        } else {
                          cubit.errorMessage = '';
                          cubit.insertToDatabase(
                            context: context,
                            title: cubit.titleController.text,
                            startTime: cubit.startTimeController.text,
                            endTime: cubit.endTimeController.text,
                            deadline: cubit.dateController.text,
                            remind: cubit.selectedReminderValue,
                            color: cubit.colorSelected!,
                            status: 'active',
                            isFav: false,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
