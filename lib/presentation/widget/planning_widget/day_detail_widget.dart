import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';
import 'package:running_planning/domain/entities/planning.dart';

class DayDetailWidget extends StatelessWidget {
  final Planning dailyProgram;

  const DayDetailWidget({super.key, required this.dailyProgram});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dailyProgram.race.isNotEmpty)
          Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Jour de course !!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyProgram.race.length,
                  itemBuilder: (context, index) {
                    final race = dailyProgram.race[index];
                    return ListTile(
                      title: Text(race.name),
                      subtitle: Text(
                        "${race.distance}Km - ${race.type.label}",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        if (dailyProgram.training.isNotEmpty)
          Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Entrainement du jour : ${dailyProgram.training.length}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyProgram.training.length,
                  itemBuilder: (context, index) {
                    final training = dailyProgram.training[index];
                    return ListTile(
                      title: Text(training.description),
                      subtitle: Text(
                        "Du ${DateFormat('d MM yyyy', 'fr_FR').format(training.startDate)} au ${DateFormat('d MM yyyy', 'fr_FR').format(training.endDate)}",
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        else
          Padding(
            padding: EdgeInsetsGeometry.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Pas d'entrainement aujourd'hui",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (dailyProgram.prepa.isNotEmpty)
          Padding(
            padding: EdgeInsetsGeometry.only(top: 4.0, left: 8.0, right: 8.0, bottom: 0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Prepas en cours : ${dailyProgram.prepa.length}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyProgram.prepa.length,
                  itemBuilder: (context, index) {
                    final prepa = dailyProgram.prepa[index];
                    return ListTile(
                      title: Text(prepa.name),
                      subtitle: Text(
                        "Du ${DateFormat('d MM yyyy', 'fr_FR').format(prepa.startDate)} au ${DateFormat('d MM yyyy', 'fr_FR').format(prepa.endDate)}",
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
