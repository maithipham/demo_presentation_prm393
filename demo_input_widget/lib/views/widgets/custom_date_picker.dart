import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';

class CustomDatePicker extends ConsumerWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    // Read the light theme state(An)
    final isLightTheme = ref.watch(isLightThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DATE & TIME FILTER',
          style: TextStyle(
            color: isLightTheme
                ? Colors.black
                : Colors.cyanAccent,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // DATE
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            ref.read(selectedDateProvider.notifier).state = date;
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isLightTheme
                  ? Colors.white
                  : Colors.blueGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black26),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Colors.cyanAccent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Select birth date'
                        : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    style: TextStyle(color: isLightTheme
                        ? Colors.black87
                        : Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // TIME
        InkWell(
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            ref.read(selectedTimeProvider.notifier).state = time;
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isLightTheme
                  ? Colors.white
                  : Colors.blueGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black26),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedTime == null
                        ? 'Select shift time'
                        : selectedTime.format(context),
                    style: TextStyle(color: isLightTheme
                        ? Colors.black87
                        : Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}