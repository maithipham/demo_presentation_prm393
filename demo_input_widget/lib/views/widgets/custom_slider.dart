import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';


class CustomSliderWidget extends ConsumerWidget {
  const CustomSliderWidget({
    super.key,
  });

  @override
  Widget build( BuildContext context, WidgetRef ref,) {
    final age =
    ref.watch(ageProvider);

    final salary =
    ref.watch(
      salaryProvider,
    );

    return Column(
      children: [
        Slider(
          value: age,
          min: 0,
          max: 100,
          onChanged: (value) {
            ref
                .read(
              ageProvider
                  .notifier,
            )
                .state = value;
          },
        ),

        RangeSlider(
          values: salary,
          min: 0,
          max: 10000,
          onChanged: (value) {
            ref
                .read(
              salaryProvider
                  .notifier,
            )
                .state = value;
          },
        ),
      ],
    );
  }
}