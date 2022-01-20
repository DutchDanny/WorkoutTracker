// Class used in Routines. A Single Class is a Single Workout Entry in a routine.
import 'package:flutter/widgets.dart';
import 'package:workout_tracker/dbModels/WorkoutEntry.dart';

class WorkoutCard {
  WorkoutEntry entry;
  int numSets;
  List<double> metricList;
  List<double> countList;
  List<TextEditingController> metricController;
  List<TextEditingController> countController;

  WorkoutCard(WorkoutEntry workoutEntry)
  {
    metricList = [];
    countList = [];
    metricController = [];
    countController = [];
    entry = workoutEntry;
    numSets = 0;
  }

  void addSet(double metric, double count)
  {
    numSets += 1;
    metricList.add(metric);
    countList.add(count);
    metricController.add(new TextEditingController());
    countController.add(new TextEditingController());
  }

  void remove(int ind)
  {
    numSets -= 1;
    metricList.removeAt(ind);
    countList.removeAt(ind);
    metricController.removeAt(ind);
    countController.removeAt(ind);
  }

  Map<String, Object> getMap() {
    Map<String, Object> retMap = new Map();
    retMap["id"] = entry.id;
    retMap["numSet"] = numSets;

    List<Map<String, Object>> sets = [];
    for (int i = 0; i < numSets; i++) {
      Map<String, double> set = new Map();
      set["metric"] = metricList[i];
      set["count"] = countList[i];
    }
  }
}