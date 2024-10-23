import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:todolist/views/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);
  final Task task;

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subTitle;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /////
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (ctx) => TaskView(
                    titleTaskController: textEditingControllerForTitle,
                    descriptionTaskController: textEditingControllerForSubTitle,
                    task: widget.task)));
      },
      //Main Card
      child: AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          duration: const Duration(milliseconds: 600),
          decoration: BoxDecoration(
              color: widget.task.isCompleted
                  ? const Color.fromARGB(154, 119, 144, 229)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                )
              ]),
          child: ListTile(
            ///Checkbox
            leading: GestureDetector(
              onTap: () {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.grey),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),

            //Task Title
            title: Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 5),
              child: Text(
                textEditingControllerForTitle.text,
                style: TextStyle(
                    color: widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ),

            //Task description
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textEditingControllerForSubTitle.text,
                  style: TextStyle(
                      color: widget.task.isCompleted
                          ? AppColors.primaryColor
                          : Colors.black,
                      fontWeight: FontWeight.w300,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('hh:mm a')
                              .format(widget.task.createdaAtTime),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          DateFormat.yMMMEd()
                              .format(widget.task.createdaAtDate),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
