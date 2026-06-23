import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';

class CheckboxRadioSwitch extends ConsumerWidget {
  const CheckboxRadioSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);
    final isHiddenEmail = ref.watch(agreeProvider);
    final isLightTheme = ref.watch(notificationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Status & Demographics',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Checkbox
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Hidden email',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          value: isHiddenEmail,
          activeColor: Colors.cyanAccent,
          onChanged: (value) {
            ref.read(agreeProvider.notifier).state = value ?? false;
          },
        ),

        const SizedBox(height: 8),

        // Radio
        const Text(
          'Gender',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 13,
          ),
        ),

        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                value: 'All',
                groupValue: selectedGender,
                activeColor: Colors.cyanAccent,
                onChanged: (value) {
                  ref.read(genderProvider.notifier).state = value!;
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Male',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                value: 'Male',
                groupValue: selectedGender,
                activeColor: Colors.cyanAccent,
                onChanged: (value) {
                  ref.read(genderProvider.notifier).state = value!;
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Female',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                value: 'Female',
                groupValue: selectedGender,
                activeColor: Colors.cyanAccent,
                onChanged: (value) {
                  ref.read(genderProvider.notifier).state = value!;
                },
              ),
            ),
          ],
        ),

        // Switch
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Light Theme',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          secondary: Icon(
            isLightTheme
                ? Icons.light_mode
                : Icons.dark_mode,
            color: isLightTheme
                ? Colors.amberAccent
                : Colors.cyanAccent,
          ),
          value: isLightTheme,
          activeColor: Colors.amberAccent,
          onChanged: (value) {
            ref.read(notificationProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}