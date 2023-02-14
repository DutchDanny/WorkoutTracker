import 'package:flutter/material.dart';
import 'package:workout_tracker/widgets/DashboardWidget.dart';
import 'package:workout_tracker/widgets/CalendarWidget.dart';
import 'package:workout_tracker/widgets/Routine/RoutineWidget.dart';
import 'package:workout_tracker/widgets/Workout/WorkoutWidget.dart';
import 'package:workout_tracker/widgets/Setting/SettingsWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeWidget extends StatefulWidget {
  final BuildContext parentCtx;
  late final objectbox;
  HomeWidget({Key? key, required this.parentCtx, required this.objectbox});

  @override
  State createState() => _HomeState();

}

class _HomeState extends State<HomeWidget>{
  int selectedPageIndex = 2;
  bool ready = false;
  String? username = "";

  @override
  Widget build(BuildContext context){
    ready = true;
    // While Data is loading, show empty screen
    if(!ready) {
      return Scaffold(
          body: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child:
                      Text("Loading data")
                    /*Image(
                        image: AssetImage('assets/my_icon.png'),
                        width: 150,
                      )*/
                  ),
                ),
              ])
      );
    }
    // App Loads
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: [
            WorkoutWidget(objectbox: widget.objectbox),
            RoutineWidget(objectbox: widget.objectbox),
            DashboardWidget(objectbox: widget.objectbox),
            CalendarWidget(objectbox: widget.objectbox),
            SettingsWidget(objectbox: widget.objectbox),
          ][selectedPageIndex],
          bottomNavigationBar: NavigationBar(
            height: 65,
            selectedIndex: selectedPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedPageIndex = index;
              });
            },
            destinations: <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(Icons.fitness_center),
                icon: Icon(Icons.fitness_center_outlined),
                label: AppLocalizations.of(context)!.workout,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.repeat),
                icon: Icon(Icons.repeat_outlined),
                label: AppLocalizations.of(context)!.routine,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.insert_chart),
                icon: Icon(Icons.insert_chart_outlined),
                label: AppLocalizations.of(context)!.dashboard,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.calendar_today),
                icon: Icon(Icons.calendar_today_outlined),
                label: AppLocalizations.of(context)!.calendar,
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: AppLocalizations.of(context)!.settings,
              ),
            ],
          ),
        )
    );
  }
}