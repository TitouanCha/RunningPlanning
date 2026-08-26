import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:running_planning/injection_container.dart';
import 'package:running_planning/presentation/bloc/race_detail/race_detail_bloc.dart';
import 'package:running_planning/presentation/screen/prepa_detail_screen.dart';

class RaceDetailScreen extends StatelessWidget {
  final String raceId;

  const RaceDetailScreen({super.key, required this.raceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RaceDetailBloc>()..add(LoadRaceDetail(raceId: raceId)),
      child: Scaffold(
        body: BlocBuilder<RaceDetailBloc, RaceState>(
          builder: (context, state) {
            if (state.status == RaceDetailStatus.loadingRace) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == RaceDetailStatus.error) {
              return Center(child: Text(state.errorMessage ?? 'Erreur'));
            }
            final race = state.race;
            if (race == null) return const SizedBox();

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.zoomBackground],
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.deepOrangeAccent, Colors.deepOrangeAccent.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Text(
                              state.race?.name ?? "Course",
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Type : ${state.race?.type.label}",
                              style: const TextStyle(color: Colors.white70, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // -- Infos de la course --
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Informations',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(),
                                _InfoRow(
                                  icon: Icons.calendar_today,
                                  label: 'Date',
                                  value: DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(race.date),
                                ),
                                _InfoRow(
                                  icon: Icons.location_on,
                                  label: 'Lieu',
                                  value: race.location!,
                                ),
                                _InfoRow(
                                  icon: Icons.straighten,
                                  label: 'Distance',
                                  value: '${race.distance} km',
                                ),
                                const Divider(),
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  race.description!,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    height: 1.5,
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Prepas existantes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (state.prepas.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                'Aucune préparation disponible',
                                style: TextStyle(color: Colors.deepOrangeAccent),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final prepa = state.prepas[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepOrangeAccent.shade100,
                            child: Icon(
                              Icons.directions_run,
                              color: Colors.deepOrangeAccent.shade700,
                            ),
                          ),
                          title: Text(
                            prepa.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: Colors.deepOrangeAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Début : ${DateFormat('dd/MM/yyyy').format(prepa.startDate)}',
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PrepaDetailScreen(prepaId: prepa.id),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }, childCount: state.prepas.length),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.deepOrangeAccent),
          const SizedBox(width: 8),
          Text(
            '$label : ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
