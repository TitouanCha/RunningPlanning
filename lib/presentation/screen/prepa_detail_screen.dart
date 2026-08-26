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
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: BlocBuilder<PrepaDetailBloc, PrepaDetailState>(
        builder: (context, state) {
          if (state.isUserJoinedPrepa) {
            return FloatingActionButton.extended(
              onPressed: () => context.read<PrepaDetailBloc>().add(LeavePrepa(prepaId: prepaId)),
              backgroundColor: Colors.redAccent,
              icon: const Icon(Icons.exit_to_app, color: Colors.white),
              label: const Text("Quitter", style: TextStyle(color: Colors.white)),
            );
          }
          return FloatingActionButton.extended(
            onPressed: () => context.read<PrepaDetailBloc>().add(JoinPrepa(prepaId: prepaId)),
            backgroundColor: Colors.blue.shade700,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Rejoindre", style: TextStyle(color: Colors.white)),
          );
        },
      ),
      body: BlocBuilder<PrepaDetailBloc, PrepaDetailState>(
        builder: (context, state) {
          if (state.status == PrepaDetailStatus.failure) {
            return Center(child: Text(state.errorMessage ?? "Erreur de chargement"));
          }
          if (state.status == PrepaDetailStatus.loadingPrepa) {
            return const Center(child: CircularProgressIndicator());
          }

          final dateFormat = DateFormat('dd MMM yyyy', 'fr_FR');

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade900, Colors.blue.shade400],
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
                            state.prepa?.name ?? "Préparation",
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${dateFormat.format(state.prepa?.startDate ?? DateTime.now())} - ${dateFormat.format(state.prepa?.endDate ?? DateTime.now())}",
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
                      // -- Bandeau rejoint --
                      if (state.isUserJoinedPrepa) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green.shade600),
                              const SizedBox(width: 10),
                              Text(
                                "Vous avez rejoint cette préparation",
                                style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // -- Infos course --
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.flag, color: Colors.blue.shade600, size: 20),
                                  const SizedBox(width: 8),
                                  const Text("Course associée", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const Divider(height: 20),
                              RaceDetailInfoWidget(race: state.race),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // -- Titre étapes --
                      Row(
                        children: [
                          Icon(Icons.format_list_numbered, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          const Text("Étapes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Chip(
                            label: Text('${state.steps.length}'),
                            backgroundColor: Colors.blue.shade50,
                            labelStyle: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      if (state.steps.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.orange.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.orange.shade700),
                              const SizedBox(width: 10),
                              Text(
                                "Aucune étape pour cette préparation",
                                style: TextStyle(color: Colors.orange.shade800, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // -- Liste étapes --
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final step = state.steps[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade700,
                              radius: 20,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.name,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          ],
                        ),
                      ),
                    ),
                  );
                }, childCount: state.steps.length),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          );
        },
      ),
    );
  }
}
