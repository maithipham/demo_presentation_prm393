import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';

class CheckboxRadioSwitch extends ConsumerWidget {
  const CheckboxRadioSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);
    final isHiddenEmail = ref.watch(agreeProvider);
    final isLightTheme = ref.watch(isLightThemeProvider);

    final primaryTextColor =
    isLightTheme ? Colors.black87 : Colors.white;

    final secondaryTextColor =
    isLightTheme ? Colors.black54 : Colors.white54;

    final tertiaryTextColor =
    isLightTheme ? Colors.black87 : Colors.white70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'Status & Demographics',
          style: TextStyle(
            color: isLightTheme
                ? Colors.black
                : Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        // ================= CHECKBOX =================
        CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.trailing,

          title: Text(
            'Hidden email',
            style: TextStyle(
              color: tertiaryTextColor,
              fontSize: 14,
            ),
          ),

          value: isHiddenEmail,

          activeColor: Colors.cyanAccent,

          checkColor: Colors.black,

          onChanged: (value) {
            ref.read(agreeProvider.notifier).state =
                value ?? false;
          },
        ),

        const SizedBox(height: 8),

        // ================= RADIO =================
        Text(
          'Gender',
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 13,
          ),
        ),

        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,

                title: Text(
                  'All',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 12,
                  ),
                ),

                value: 'All',
                groupValue: selectedGender,
                activeColor: Colors.cyanAccent,

                onChanged: (value) {
                  ref.read(genderProvider.notifier).state =
                  value!;
                },
              ),
            ),

            Expanded(
              child: RadioListTile<String>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,

                title: Text(
                  'Male',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 12,
                  ),
                ),

                value: 'Male',
                groupValue: selectedGender,
                activeColor: Colors.cyanAccent,

                onChanged: (value) {
                  ref.read(genderProvider.notifier).state =
                  value!;
                },
              ),
            ),

            Expanded(
              child: RadioListTile<String>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,

                title: Text(
                  'Female',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 12,
                  ),
                ),

                value: 'Female',
                groupValue: selectedGender,
                activeColor: Colors.cyanAccent,

                onChanged: (value) {
                  ref.read(genderProvider.notifier).state =
                  value!;
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // ================= SWITCH =================
        SwitchListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,

          title: Text(
            'Light Theme',
            style: TextStyle(
              color: tertiaryTextColor,
              fontSize: 14,
            ),
          ),

          secondary: Icon(
            isLightTheme
                ? Icons.light_mode
                : Icons.dark_mode,
            color: isLightTheme
                ? Colors.amber
                : Colors.cyanAccent,
          ),

          value: isLightTheme,

          activeTrackColor: Colors.cyanAccent,

          activeColor: Colors.white,

          onChanged: (value) {
            ref.read(isLightThemeProvider.notifier).state =
                value;
          },
        ),
      ],
    );
  }
}