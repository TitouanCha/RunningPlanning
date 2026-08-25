import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_planning/presentation/bloc/races/races_bloc.dart';

class RacesScreen extends StatefulWidget {
  const RacesScreen({super.key});

  @override
  State<RacesScreen> createState() => _RacesScreenState();
}

class _RacesScreenState extends State<RacesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<RacesBloc>().add(LoadRaces());
        },
        label: Row(
          children: [
            Icon(Icons.add_circle_outline_outlined),
            SizedBox(width: 4),
            Text('Ajouter une course'),
          ],
        ),
      ),
      body: BlocBuilder<RacesBloc, RacesState>(
        builder: (context, state) {
          if (state.status == RaceStatus.loadingRace) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == RaceStatus.error) {
            return Center(child: Text('Erreur : ${state.errorMessage}'));
          }
          if (state.races.isEmpty) {
            return const Center(child: Text('Aucune course disponible'));
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une course...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                  ),
                  onChanged: (value) => context.read<RacesBloc>().add(
                    SearchRaces(query: _searchController.text),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<RaceListSort>(
                        initialValue: RaceListSort.dateDesc,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                        ),
                        selectedItemBuilder: (context) =>
                            RaceListSort.values.map((sort) {
                              return Row(
                                children: [
                                  const Icon(
                                    Icons.sort,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Trier par : ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(sort.label),
                                ],
                              );
                            }).toList(),
                        items: RaceListSort.values.map((sort) {
                          return DropdownMenuItem<RaceListSort>(
                            value: sort,
                            child: Text(sort.label),
                          );
                        }).toList(),
                        onChanged: (sort) {
                          if (sort != null) {
                            context.read<RacesBloc>().add(
                              SortRaces(sort: sort),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.races.length,
                  itemBuilder: (context, index) {
                    final race = state.races[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/raceDetail', arguments: race.id),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      race.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Chip(
                                    label: Text(race.type.name),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    race.location,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${race.date.day}/${race.date.month}/${race.date.year}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.straighten,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${race.distance} km'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
