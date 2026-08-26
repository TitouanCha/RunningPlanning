import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_planning/presentation/bloc/add_steps_screen/add_steps_bloc.dart';

class PrepaAddStepScreen extends StatefulWidget {
  final String prepaId;

  const PrepaAddStepScreen({super.key, required this.prepaId});

  @override
  State<PrepaAddStepScreen> createState() => _PrepaAddStepScreenState();
}

class _PrepaAddStepScreenState extends State<PrepaAddStepScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    context.read<AddStepsBloc>().add(InitStepId(prepaId: widget.prepaId));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? now) : (_endDate ?? _startDate ?? now),
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) _endDate = null;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      context.read<AddStepsBloc>().add(AddStep(
        stepName: _nameController.text.trim(),
        stepDescription: _descriptionController.text.trim(),
        startDate: _startDate!,
        endDate: _endDate!,
      ));
    } else if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner les dates de début et de fin.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une étape'),
        centerTitle: true,
      ),
      body: BlocListener<AddStepsBloc, AddStepsState>(
        listener: (context, state) {
          if (state.stepStatus == StepStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Étape ajoutée avec succès !')),
            );
            Navigator.pushNamed(context, '/PrepaDetail', arguments: state.stepId);
          } else if (state.stepStatus == StepStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage.toString())),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Informations', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nom de l\'étape',
                            prefixIcon: Icon(Icons.label_outline),
                            border: OutlineInputBorder(),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            prefixIcon: Icon(Icons.description_outlined),
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 4,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // -- Dates --
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Période', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _DatePickerTile(
                          label: 'Date de début',
                          date: _startDate,
                          icon: Icons.calendar_today_outlined,
                          onTap: () => _pickDate(context, true),
                        ),
                        const Divider(height: 24),
                        _DatePickerTile(
                          label: 'Date de fin',
                          date: _endDate,
                          icon: Icons.event_outlined,
                          onTap: _startDate == null ? null : () => _pickDate(context, false),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // -- Bouton --
                BlocBuilder<AddStepsBloc, AddStepsState>(
                  builder: (context, state) {
                    final isLoading = state.stepStatus == StepStatus.loading;
                    return FilledButton.icon(
                      onPressed: isLoading ? null : _submit,
                      icon: isLoading
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.check),
                      label: const Text('Ajouter l\'étape'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final IconData icon;
  final VoidCallback? onTap;

  const _DatePickerTile({required this.label, required this.date, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, color: onTap == null ? Colors.grey : theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  const SizedBox(height: 2),
                  Text(
                    date != null ? '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}' : 'Sélectionner',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: date == null ? Colors.grey : null,
                      fontWeight: date != null ? FontWeight.w500 : null,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}