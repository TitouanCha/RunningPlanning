import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
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
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyProgram.race.length,
                  itemBuilder: (context, index) {
                    final race = dailyProgram.race[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              race.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _RaceChip(
                                  icon: Icons.straighten,
                                  label: "${race.distance} km",
                                  color: Colors.deepOrange,
                                ),
                                const SizedBox(width: 8),
                                _RaceChip(
                                  icon: Icons.category,
                                  label: race.type.label,
                                  color: Colors.blueGrey,
                                ),
                                const SizedBox(width: 8),
                                _RaceChip(
                                  icon: Icons.location_on,
                                  label: race.location,
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                            if (race.description.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                race.description,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        if (dailyProgram.prepa.isNotEmpty)
          Padding(
            padding: EdgeInsetsGeometry.only(
              top: 4.0,
              left: 8.0,
              right: 8.0,
              bottom: 0,
            ),
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
                    final prepaSteps = dailyProgram.steps;
                    return Column(
                      children: [
                        if (index > 0)
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black26,
                            indent: 8,
                            endIndent: 8,
                          ),
                        Text(
                          prepa.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Du ${DateFormat('dd/MM/yyyy', 'fr_FR').format(prepa.startDate)} au ${DateFormat('dd/MM/yyyy', 'fr_FR').format(prepa.endDate)}",
                        ),
                        if (prepaSteps.isNotEmpty)
                          ...List.generate(prepaSteps.length, (i) {
                            final step = prepaSteps[i];
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        step.isDone
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: step.isDone
                                            ? Colors.green
                                            : Colors.grey,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          step.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            decoration: step.isDone
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: step.isDone
                                                ? Colors.grey
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (step.description.isNotEmpty)
                                    Row(
                                      children: [
                                        Text(
                                          "Description : ${step.description}",
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          }),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            left: 8,
                            right: 8,
                            bottom: 4,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "Entrainement du jour : ${dailyProgram.training.length}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
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
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.radio_button_unchecked,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${training.description} - ${training.runtimeType}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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

class _RaceChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _RaceChip({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      label: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
