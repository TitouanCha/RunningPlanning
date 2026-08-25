import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/race.dart';

class RaceDetailInfoWidget extends StatelessWidget {
  final Race? race;
  const RaceDetailInfoWidget({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Nom --
        Row(
          children: [
            SvgPicture.asset("assets/icons/cup.svg", width: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                race?.name ?? '',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // -- Chips distance & type --
        Wrap(
          spacing: 8,
          children: [
            _InfoChip(
              icon: Icons.straighten,
              label: '${race?.distance} km',
              color: Colors.blue.shade700,
            ),
            _InfoChip(
              icon: Icons.category,
              label: race?.type.label ?? '',
              color: Colors.blue.shade700,
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
        // -- Date --
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.calendar_today, size: 16, color: Colors.blue.shade700),
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat('d MMMM yyyy', 'fr_FR').format(race?.date ?? DateTime.now()),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // -- Lieu --
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade50,
              child: SvgPicture.asset("assets/icons/map-point.svg", width: 16),
            ),
            const SizedBox(width: 10),
            Text(
              race?.location ?? '',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}