import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_planning/presentation/bloc/user_race/user_race_bloc.dart';

class RacesScreen extends StatelessWidget {
  const RacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action à définir
        },
        icon: const Icon(Icons.add),
        label: const Text("Rejoindre une nouvelle course"),
      ),
      body: BlocBuilder<UserRaceBloc, UserRaceState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state.status == UserRaceStatus.error)
                    Center(
                      child: Text(
                        state.errorMessage ?? "Une erreur est survenue",
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Vos courses à venir",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  if (state.status == UserRaceStatus.loadingNextRace)
                    const Center(child: CircularProgressIndicator()),
                  if (state.userNextPrepa.isNotEmpty)
                    ListView.builder(
                      itemCount: state.userNextPrepa.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/PrepaDetail', arguments: state.userNextPrepa[index].id);
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(state.userNextPrepa[index].raceName),
                              subtitle: Text(
                                state.userNextPrepa[index].raceDate.toString(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  SizedBox(height: 18.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vos courses passées",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<UserRaceBloc>().add(TogglePastRaceDisplayed());
                            if(!state.isPastRaceDisplayed) {
                              context.read<UserRaceBloc>().add(LoadUserRaces(isActiveRaces: false));
                            }
                          },
                          child: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.0),
                  if (state.status == UserRaceStatus.loadingPastRace)
                    const Center(child: CircularProgressIndicator()),
                  if (state.userPastPrepa.isNotEmpty && state.isPastRaceDisplayed)
                    ListView.builder(
                      itemCount: state.userPastPrepa.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/PrepaDetail', arguments: state.userPastPrepa[index].id);
                            },
                          child: Card(
                            child: ListTile(
                              title: Text(state.userPastPrepa[index].raceName),
                              subtitle: Text(
                                state.userPastPrepa[index].raceDate.toString(),
                              ),
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
