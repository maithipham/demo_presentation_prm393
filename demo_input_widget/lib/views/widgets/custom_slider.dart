import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';
import '../../data/repositories/user_repository.dart';

class CustomSliderWidget extends ConsumerWidget {
  const CustomSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy kích thước danh sách từ repository (mặc định là 10.0)
    final maxSize = ref.watch(fetchUsersSizeProvider).value?.toDouble() ?? 10.0;
    
    final maxId = ref.watch(ageProvider);
    final range = ref.watch(salaryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lọc theo ID tối đa (Slider): ID < ${maxId.round()}'
            , style: const TextStyle(color: Colors.white)),
        Slider(
          value: maxId,
          min: 1,
          max: maxSize + 1, divisions: maxSize.toInt(),
          onChanged: (val) => ref.read(ageProvider.notifier).state = val,
        ),

        Text('Lọc theo ID trong khoảng (Range): ID: ${range.start.round()} - ${range.end.round()}'
            , style: const TextStyle(color: Colors.white)),
        RangeSlider(
          values: range,
          min: 1, max: maxSize, divisions: maxSize.toInt() - 1,
          onChanged: (val) => ref.read(salaryProvider.notifier).state = val,
        ),
      ],
    );
  }
}