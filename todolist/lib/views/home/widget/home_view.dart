import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/extensions/space_exs.dart';
import 'package:todolist/main.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/utils/app_str.dart';
import 'package:todolist/utils/constants.dart';
import 'package:todolist/views/home/components/home_app_bar.dart';
import 'package:todolist/views/home/components/slider_drawer.dart';
import 'package:todolist/views/home/widget/task_widget.dart';

import '../components/fab.dart';
import 'package:flutter/material.dart';
import 'package:todolist/utils/app_colors.dart';

import 'package:animate_do/animate_do.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerkey = GlobalKey<SliderDrawerState>();

  //Check value of circle indicator
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  // final List<int> testing = [];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
        valueListenable: base.dataStore.listenToTask(),
        builder: (ctx, Box<Task> box, Widget? child) {
          var tasks = box.values.toList();

          tasks.sort((a, b) => a.createdaAtDate.compareTo(b.createdaAtDate));

          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: Fab(),
            body: SliderDrawer(
              key: drawerkey,
              isDraggable: false,
              animationDuration: 1000,
              slider: CustomDrawer(),
              appBar: HomeAppBar(
                drawerkey: drawerkey,
              ),
              child: _buildHomeBody(textTheme, base, tasks),
            ),
          );
        });
  }

  Widget _buildHomeBody(
      TextTheme textTheme, BaseWidget base, List<Task> tasks) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 100,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
                    ),
                  ),
                  25.w,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStr.mainTitle,
                        style: textTheme.displayMedium,
                      ),
                      3.h,
                      Text(
                        "${checkDoneTask(tasks)} of ${tasks.length} tasks",
                        style: textTheme.titleSmall,
                      )
                    ],
                  ),
                ],
              ),
            ),
            //Divider ->
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 2,
                indent: 100,
              ),
            ),

            //Tasks
            SizedBox(
              width: double.infinity,
              height: 600,
              child: tasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: tasks.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var task = tasks[index];
                        return Dismissible(
                            direction: DismissDirection.horizontal,
                            onDismissed: (_) {
                              base.dataStore.deleteTask(task: task);
                            },
                            background: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                ),
                                8.w,
                                const Text(
                                  AppStr.deletedTask,
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                            key: Key(task.id),
                            child: TaskWidget(
                              task: task,
                            ));
                      })
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Column(
                              children: [
                                Lottie.asset(lottieURL,
                                    animate: tasks.isNotEmpty ? false : true),
                              ],
                            ),
                          ),
                        ),
                        FadeInUp(
                            from: 30, child: const Text(AppStr.doneAlltask)),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
