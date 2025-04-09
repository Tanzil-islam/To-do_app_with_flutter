

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';

///
import '../../main.dart';
import '../../models/task.dart';
import '../../utils/colors.dart';
import '../../utils/constanst.dart';
import '../../utils/strings.dart';

// ignore: must_be_immutable
class TaskView extends StatefulWidget {
  TaskView({
    Key? key,
    required this.taskControllerForTitle,
    required this.taskControllerForSubtitle,
    required this.task,
  }) : super(key: key);

  TextEditingController? taskControllerForTitle;
  TextEditingController? taskControllerForSubtitle;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;

  /// Show Selected Time As String Format
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a')
          .format(widget.task!.createdAtTime)
          .toString();
    }
  }

  /// Show Selected Time As DateTime Format
  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateTime.now();
      } else {
        return time;
      }
    } else {
      return widget.task!.createdAtTime;
    }
  }

  /// Show Selected Date As String Format
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  // Show Selected Date As DateTime Format
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  /// If any Task Already exist return TRUE otherwise FALSE
  bool isTaskAlreadyExistBool() {
    if (widget.taskControllerForTitle?.text == null &&
        widget.taskControllerForSubtitle?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  /// If any task already exist app will update it otherwise the app will add a new task
  dynamic isTaskAlreadyExistUpdateTask() {
    if (widget.taskControllerForTitle?.text != null &&
        widget.taskControllerForSubtitle?.text != null) {
      try {
        widget.taskControllerForTitle?.text = title;
        widget.taskControllerForSubtitle?.text = subtitle;

        // widget.task?.createdAtDate = date!;
        // widget.task?.createdAtTime = time!;

        widget.task?.save();
        Navigator.of(context).pop();
      } catch (error) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      if (title != null && subtitle != null) {
        var task = Task.create(
          title: title,
          createdAtTime: time,
          createdAtDate: date,
          subtitle: subtitle,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.of(context).pop();
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  /// Delete Selected Task
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 25),
                    _buildTitleField(),
                    const SizedBox(height: 20),
                    _buildNoteField(),
                    const SizedBox(height: 30),
                    _buildTimeAndDateSection(),
                    const SizedBox(height: 40),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: MyColors.primaryColor,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        isTaskAlreadyExistBool() ? "New Task" : "Update Task",
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: MyColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          isTaskAlreadyExistBool() ? MyString.addNewTask : MyString.updateCurrentTask,
          style: TextStyle(
            color: MyColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            "Task Title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.taskControllerForTitle,
            maxLines: 3,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              hintText: "What do you need to do?",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            onFieldSubmitted: (value) {
              title = value;
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) {
              title = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            "Note",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.taskControllerForSubtitle,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              hintText: "Add details about your task",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.bookmark_border_rounded,
                color: Colors.grey,
              ),
            ),
            onFieldSubmitted: (value) {
              subtitle = value;
            },
            onChanged: (value) {
              subtitle = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeAndDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 5, bottom: 15),
          child: Text(
            "Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildTimeSelection(),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildDateSelection(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return GestureDetector(
      onTap: () {
        DatePicker.showTimePicker(
          context,
          showTitleActions: true,
          showSecondsColumn: false,
          onChanged: (_) {},
          onConfirm: (selectedTime) {
            setState(() {
              if (widget.task?.createdAtTime == null) {
                time = selectedTime;
              } else {
                widget.task!.createdAtTime = selectedTime;
              }
            });
            FocusManager.instance.primaryFocus?.unfocus();
          },
          currentTime: showTimeAsDateTime(time),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              color: MyColors.primaryColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Time",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    showTime(time),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now(),
          maxTime: DateTime(2030, 3, 5),
          onChanged: (_) {},
          onConfirm: (selectedDate) {
            setState(() {
              if (widget.task?.createdAtDate == null) {
                date = selectedDate;
              } else {
                widget.task!.createdAtDate = selectedDate;
              }
            });
            FocusManager.instance.primaryFocus?.unfocus();
          },
          currentTime: showDateAsDateTime(date),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: MyColors.primaryColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Date",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    showDate(date),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isTaskAlreadyExistBool())
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                deleteTask();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: MyColors.primaryColor,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: MyColors.primaryColor),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text(
                MyString.deleteTask,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (!isTaskAlreadyExistBool()) const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              isTaskAlreadyExistUpdateTask();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
            ),
            child: Text(
              isTaskAlreadyExistBool()
                  ? MyString.addTaskString
                  : MyString.updateTaskString,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
