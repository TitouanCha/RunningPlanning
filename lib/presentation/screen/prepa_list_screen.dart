import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:running_planning/presentation/bloc/prepa_list/prepa_list_bloc.dart';

class PrepaListScreen extends StatefulWidget {
  const PrepaListScreen({super.key});

  @override
  State<PrepaListScreen> createState() => _PrepaListScreenState();
}

class _PrepaListScreenState extends State<PrepaListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PrepaListBloc, PrepaListState>(
        builder: (context, state) {
          final bloc = context.read<PrepaListBloc>();
          final displayedPrepas = state.prepas
              .where((p) => p.name.toLowerCase().contains(_searchController.text.toLowerCase()))
              .toList();

          return Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher une prépa...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.sort, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Text('Trier par :', style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 8),
                    DropdownButton<PrepaListSort>(
                      value: state.sort,
                      underline: const SizedBox(),
                      items: PrepaListSort.values
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                          .toList(),
                      onChanged: (val) => val != null ? bloc.add(ChangePrepaSort(val)) : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: displayedPrepas.length,
                  itemBuilder: (context, index) {
                    final prepa = displayedPrepas[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/PrepaDetail', arguments: prepa.id),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(prepa.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text("Du ${DateFormat('dd/MM/yyyy', 'fr_FR').format(prepa.startDate)} au ${DateFormat('dd/MM/yyyy', 'fr_FR').format(prepa.endDate)}"),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        _InfoChip(icon: Icons.timer_outlined, label: '${prepa.prepaDuration} jour.'),
                                        const SizedBox(width: 8),
                                        _InfoChip(icon: Icons.flag_outlined, label: '${prepa.raceDistance} km'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.grey),
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.blue.shade800,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue.shade800,
              fontSize: 14,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
