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

    // ==================== FIX: Đọc trạng thái Light/Dark Mode ====================
    final isLightTheme = ref.watch(isLightThemeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==================== FIX: Đổi màu chữ theo Theme ====================
        Text(
          'Lọc theo ID tối đa (Slider): ID < ${maxId.round()}',
          style: TextStyle(
            color: isLightTheme
                ? Colors.black87 // Light Mode
                : Colors.white,  // Dark Mode
          ),
        ),
        Slider(
          value: maxId,
          min: 1,
          max: maxSize + 1, divisions: maxSize.toInt(),
          onChanged: (val) => ref.read(ageProvider.notifier).state = val,
        ),

        // ==================== FIX: Đổi màu chữ theo Theme ====================
        Text(
          'Lọc theo ID trong khoảng (Range): ID: ${range.start.round()} - ${range.end.round()}',
          style: TextStyle(
            color: isLightTheme
                ? Colors.black87 // Light Mode
                : Colors.white,  // Dark Mode
          ),
        ),
        RangeSlider(
          values: range,
          min: 1, max: maxSize, divisions: maxSize.toInt() - 1,
          onChanged: (val) => ref.read(salaryProvider.notifier).state = val,
        ),
      ],
    );
  }
}