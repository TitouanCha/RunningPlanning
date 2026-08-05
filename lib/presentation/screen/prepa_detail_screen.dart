import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_planning/presentation/bloc/prepa_detail/prepa_detail_bloc.dart';
import 'package:running_planning/presentation/widget/race_detail_widget.dart';

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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaceDetailInfoWidget(race: state.race),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Prepa du ${state.prepa?.startDate.toString()} au ${state.prepa?.endDate.toString()}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Etapes 1 de la préparation",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Nom de l'étape 1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
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
