import 'package:awesome_icons/awesome_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/logic/cubit/cubit.dart';
import 'package:todo/style/colors.dart';

Widget defaultButton({
  required BuildContext context,
  Color color = MyColors.myGreen,
  required String text,
  double width = double.infinity,
  double? height,
  EdgeInsetsGeometry? padding,
  void Function()? onClick,
}) =>
    Padding(
      padding: padding = EdgeInsets.zero,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: MaterialButton(
            onPressed: onClick,
            child: Text(
              text,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            )),
      ),
    );

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultFormField({
  required String hintText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  bool isIcon = false,
  double? width,
  double? height,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20.0),
  void Function()? onTap,
  FormFieldValidator<String>? validator,
  Icon? icon,
}) =>
    Container(
      width: width = double.infinity,
      height: height = 50,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: isIcon ? icon : null,
        ),
        onTap: onTap,
        validator: validator,
        cursorColor: Colors.grey,
      ),
    );

Widget buildTaskItem(Map model, context) {
  String valueString = model['color'].split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  Color color = Color(value);

  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      if (direction == DismissDirection.endToStart) {
        AppCubit.get(context).deleteTask(model);
      } else if (direction == DismissDirection.startToEnd) {
        AppCubit.get(context).deleteTask(model);
      }
    },
    background: const ListTile(
      leading: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    secondaryBackground: const ListTile(
      leading: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Checkbox(
            value: model['status'] == 'completed' ? true : false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
            onChanged: (value) {
              if (value! == true) {
                AppCubit.get(context).updateTaskStatus(model,
                    model['status'] == 'completed' ? 'active' : 'completed');
              } else {
                AppCubit.get(context).updateTaskStatus(model,
                    model['status'] == 'active' ? 'completed' : 'active');
              }
            },
            checkColor: Colors.white,
            activeColor:
                model['status'] == 'completed' ? Colors.green : Colors.white,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['start_time']}',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${model['title']}',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).setFav(model);
            },
            icon: model['is_fav'] == 'true'
                ? const Icon(
                    FontAwesomeIcons.solidHeart,
                    size: 18,
                  )
                : const Icon(
                    FontAwesomeIcons.heart,
                    size: 18,
                  ),
            color: model['is_fav'] == 'true' ? Colors.red : Colors.white,
          ),
        ],
      ),
    ),
  );
}

Widget taskBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: tasks.length),
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-2506.jpg?w=1480&t=st=1658988817~exp=1658989417~hmac=70ff4281ee4f48eef43bb4b63f67f538f0e2185c1d79bb3f708855318379d5c9'),
          ],
        ),
      ),
    );
