import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:running_planning/presentation/bloc/prepa_detail/prepa_detail_bloc.dart';
import 'package:running_planning/presentation/widget/detail_widget/race_detail_widget.dart';

class PrepaDetailScreen extends StatelessWidget {
  final String prepaId;

  const PrepaDetailScreen({super.key, required this.prepaId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: BlocBuilder<PrepaDetailBloc, PrepaDetailState>(
          builder: (context, state) {
            return Text(state.prepa?.name ?? "Prepa Detail");
          },
        ),
      ),
      body: BlocBuilder<PrepaDetailBloc, PrepaDetailState>(
        builder: (context, state) {
          if (state.status == PrepaDetailStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? "Erreur de chargement"),
            );
          }
          if (state.status == PrepaDetailStatus.loadingPrepa) {
            return Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Prepa du ${DateFormat('d/MM/yyyy', 'fr_FR').format(state.prepa?.startDate ?? DateTime.now())} au ${DateFormat('d/MM/yyyy', 'fr_FR').format(state.prepa?.endDate ?? DateTime.now())}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaceDetailInfoWidget(race: state.race),
                  ),
                  if (state.steps.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 4.0),
                      child: Text(
                        "Etapes de la prepa : ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  if (state.steps.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Aucune étape pour cette préparation",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.steps.length,
                    itemBuilder: (context, index) {
                      final step = state.steps[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Etapes ${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                step.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
