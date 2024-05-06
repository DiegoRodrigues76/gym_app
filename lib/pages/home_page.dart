import 'package:flutter/material.dart';
import 'package:habit_tracker/components/add_button.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/data/hive_database.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance of database
  HabitDatabase db = HabitDatabase();

  final _myBox = Hive.box('Habit_Database');

  @override
  void initState() {
    if (_myBox.get('CURRENT_HABIT_LIST') == null) {
      db.createDefaultData();
    }
    else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();
  void AddNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: canelDialogBox,
          hintText: 'Enter habit name...',
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void canelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: canelDialogBox,
          hintText: db.todaysHabitList[index][0],
        );
      },
    );
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    Navigator.pop(context);
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            //Colors.grey.shade400,
            Colors.blueGrey,
            Colors.black,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Minimalistic Habit Tracker',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 100,
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: AddHabitButton(onPressed: AddNewHabit),
        body: ListView(
          children: [
            MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get('START_DATE')),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todaysHabitList[index][0],
                  habitCompleted: db.todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
