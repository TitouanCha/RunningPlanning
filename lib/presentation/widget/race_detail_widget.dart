
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/race.dart';

class RaceDetailInfoWidget extends StatelessWidget{
  final Race? race;
  const RaceDetailInfoWidget({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shadowColor: Colors.grey,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/cup.svg",
                    width: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "${race?.name}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "${race?.distance}Km - ${race?.type.label}",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Le ${DateFormat('d/MM/yyyy', 'fr_FR').format(race?.date ?? DateTime.now()) }",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/map-point.svg", width: 24.0),
                  SizedBox(width: 8.0),
                  Text(
                    "${race?.location}",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}