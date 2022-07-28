import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/components.dart';
import 'package:todo/logic/cubit/cubit.dart';
import 'package:todo/style/colors.dart';
import 'package:todo/style/themes.dart';

import '../../logic/cubit/states.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        var allTasks = AppCubit.get(context).tasks;

        return Scaffold(
          appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                'Schedule',
                style: headingStyle,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 15,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.grey)),
                  ),
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: DatePicker(
                    DateTime.now(),
                    height: 80,
                    width: 70,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: MyColors.myGreen,
                    selectedTextColor: Colors.white,
                    dateTextStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    dayTextStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    monthTextStyle: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    onDateChange: (date) {
                      setState(() {
                        selectedDay = date;
                      });
                    },
                  ),
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat.EEEE().format(selectedDay),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat.yMMMd().format(selectedDay),
                      style: titleStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                taskBuilder(tasks: allTasks),
                const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}
