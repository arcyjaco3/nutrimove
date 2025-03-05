
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:nutrimove/themes/theme.dart';
import 'package:nutrimove/widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/add_task_screen.dart';
import '../widgets/app_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar(){
    return Container(
            margin: const EdgeInsets.only(top: 20,left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: colorWhite,
              dateTextStyle: GoogleFonts.lato(
               textStyle:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
              )
              ),
              dayTextStyle: GoogleFonts.lato(
               textStyle:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
              )
              ),
              monthTextStyle: GoogleFonts.lato(
               textStyle:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
              )
              ),
            )
          );
  }

  _addTaskBar(){
    return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,),
                Text('Today', )
              ],
            )
            ),
            MyButton(
              label: '+ Add Task',
               onTap: () {
                  Navigator.push(
                    context,
                   MaterialPageRoute(builder: (context) => AddTaskScreen()),
                   );
               }
               )
          ],)
          );
  }

}
 
