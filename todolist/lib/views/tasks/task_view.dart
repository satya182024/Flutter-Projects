import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';
import 'package:todolist/extensions/space_exs.dart';
import 'package:todolist/main.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/utils/app_colors.dart';
import 'package:todolist/utils/app_str.dart';
import 'package:todolist/utils/constants.dart';
import 'package:todolist/views/home/components/date_time_selection.dart';
import 'package:todolist/views/home/components/rep_textfield.dart';
import 'package:todolist/views/tasks/widget/task_view_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView(
      {super.key,
      required this.titleTaskController,
      required this.descriptionTaskController,
      required this.task});

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  //if any task exist already, return true else false
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  //Show selected time as string format
  String showTime(DateTime? time) {
    if (widget.task?.createdaAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdaAtTime)
          .toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdaAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdaAtDate).toString();
    }
  }

  //show selected date as DateFormat for initTime
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdaAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdaAtDate;
    }
  }

  bool isTaskAlreadyExist() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  //Main function for creating or updating tasks....
  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    ///HERE we update the current task
    if (widget.titleTaskController?.text != null &&
        widget.descriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title;
        widget.descriptionTaskController?.text = subTitle;
        widget.task?.save();

        Navigator.pop(context);
        //TODO pop page
      } catch (e) {
        //if user wanted to update task but enter nothing
        updateTaskWarning(context);
      }
      //here we create a new task
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
            title: title,
            subTitle: subTitle,
            createdAtDate: date,
            createdAtTime: time);
        //we are adding this new task to Hive DB by using inherited widget
        BaseWidget.of(context).dataStore.addTask(task: task);

        Navigator.pop(context);
      } else {
//warning
        emptyWarning(context);
      }
    }
  }

  //delete function
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopSideTexts(textTheme),
                _buildMainTaskViewActivity(textTheme, context),

                //Bottom side buttons
                _buildBottomSideButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Bottom side buttons
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          //Delete task
          isTaskAlreadyExist()
              ? Container()
              : MaterialButton(
                  onPressed: () {
                    deleteTask();
                    Navigator.pop(context);
                  },
                  minWidth: 150,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  height: 55,
                  child: Row(
                    children: [
                      const Icon(Icons.close, color: AppColors.primaryColor),
                      5.w,
                      const Text(
                        AppStr.deleteTask,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),

          //Add or update task
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherWiseCreate();
              log("New Task has been addeed");
            },
            minWidth: 150,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: AppColors.primaryColor,
            height: 55,
            child: Text(
              isTaskAlreadyExist()
                  ? AppStr.addTaskString
                  : AppStr.updateTaskString,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      height: 530,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          ///Task Title
          RepTextField(
            // controller: widget.titleTaskController ),
            controller: widget.titleTaskController ?? TextEditingController(),
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
          ),
          10.h,
          RepTextField(
            controller:
                widget.descriptionTaskController ?? TextEditingController(),
            isForDescription: true,
            onFieldSubmitted: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
          ),

          ///Time Selector
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 280,
                        child: TimePickerWidget(
                          initDateTime: showDateAsDateTime(time),
                          onChange: (_, __) {},
                          dateFormat: 'HH:mm',
                          onConfirm: (dateTime, _) {
                            setState(() {
                              if (widget.task?.createdaAtTime == null) {
                                time = dateTime;
                              } else {
                                widget.task!.createdaAtTime = dateTime;
                              }
                            });
                          },
                        ),
                      ));
            },
            title: AppStr.timeString,
            time: showTime(time),
          ),
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(context,
                  maxDateTime: DateTime(2030, 4, 5),
                  minDateTime: DateTime.now(),
                  initialDateTime: showDateAsDateTime(date),
                  onConfirm: (dateTime, _) {
                setState(() {
                  if (widget.task?.createdaAtDate == null) {
                    date = dateTime;
                  } else {
                    widget.task!.createdaAtDate = dateTime;
                  }
                });
              });
            },
            title: AppStr.dateString,
            isTime: true,
            time: showDate(date),
          )
        ],
      ),
    );
  }

  Widget _buildTopSideTexts(TextTheme texttheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
                text: isTaskAlreadyExist()
                    ? AppStr.addNewTask
                    : AppStr.updateCurrentTask,
                style: texttheme.titleLarge,
                children: const [
                  TextSpan(
                      text: AppStr.taskString,
                      style: TextStyle(fontWeight: FontWeight.w400)),
                ]),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
