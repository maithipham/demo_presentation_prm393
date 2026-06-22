import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';


class CustomDatePicker extends ConsumerWidget {
  const CustomDatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final date =
            await showDatePicker(
              context: context,
              initialDate:
              DateTime.now(),
              firstDate:
              DateTime(2020),
              lastDate:
              DateTime(2030),
            );

            ref
                .read(
              selectedDateProvider
                  .notifier,
            )
                .state = date;
          },
          child:
          const Text('Date'),
        ),

        ElevatedButton(
          onPressed: () async {
            final time =
            await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.now(),
            );

            ref
                .read(
              selectedTimeProvider
                  .notifier,
            )
                .state = time;
          },
          child:
          const Text('Time'),
        ),
      ],
    );
  }
}