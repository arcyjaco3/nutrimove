import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutrimove/widgets/app_bar.dart';
import 'package:nutrimove/widgets/input_field.dart';
import '../themes/theme.dart';
import '../widgets/drop_down.dart';
import '../widgets/button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("HH:mm").format(DateTime.now()).toString();
  String _endTime = DateFormat("HH:mm").format(DateTime.now().add(Duration(hours: 1))).toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  // Listy rozwijanych przycisków
  List<int> reminderOptions = [5, 10, 15, 20];  // Lista int
  int _selectedRemind = 5;

  List<String> repeatOptions = ["None", "Daily", "Weekly", "Monthly"];  // Lista String
  String _selectedRepeat = "None";

  int _selectedColor = 0;

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2101),
    );
    if (_pickerDate != null && _pickerDate != _selectedDate) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      print('Time is not selected');
    } else {
      String _formattedTime = pickedTime.format(context);
      setState(() {
        if (isStartTime) {
          _startTime = _formattedTime;
        } else {
          _endTime = _formattedTime;
        }
      });
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(':')[0]),
        minute: int.parse(_startTime.split(':')[1]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task', style: headingStyle),
              MyInputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              MyInputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              MyInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  color: Colors.grey,
                  onPressed: _getDateFromUser,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: Icon(Icons.access_time_outlined),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: MyInputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: Icon(Icons.access_time_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              // Pierwszy rozwijany przycisk - int (minuty)
              MyDropdownField<int>(
                title: 'Remind me',
                hint: '$_selectedRemind minutes early',
                items: reminderOptions,
                selectedValue: _selectedRemind,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedRemind = newValue!;
                  });
                },
              ),
              // Drugi rozwijany przycisk - String (powtarzanie)
              MyDropdownField<String>(
                title: 'Repeat',
                hint: _selectedRepeat,
                items: repeatOptions,
                selectedValue: _selectedRepeat,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
              ),
              SizedBox(height: 18.0),
              Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  _collorPicker(),
                  MyButton(
                    label: 'Add task',
                    onTap: () {
                      print('Title: ${_titleController.text}');
                      print('Note: ${_noteController.text}');
                      print('Date: ${DateFormat.yMd().format(_selectedDate)}');
                      print('Start Time: $_startTime');
                      print('End Time: $_endTime');
                      print('Remind: $_selectedRemind minutes early');
                      print('Repeat: $_selectedRepeat');
                      print('Color: $_selectedColor');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _collorPicker() {
    return Column(
      children: [
        Text('Color', style: titleStyle),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                  print('$index');
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}