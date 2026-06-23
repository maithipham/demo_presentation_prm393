import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart'; // Dùng chính viewModel có sẵn này

class CustomDropdown extends ConsumerWidget {
  const CustomDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(cityProvider);

    // Lấy danh sách users đã fetch từ API về thông qua viewModel có sẵn
    final userListAsync = ref.watch(userViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter by Address',
          style: TextStyle(
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: userListAsync.when(
            data: (users) {
              // Tự động lọc lấy thuộc tính city từ danh sách users công khai, loại bỏ trùng lặp
              final cities = users
                  .map((user) => user.address?.city)
                  .whereType<String>() // Loại bỏ giá trị null nếu có
                  .toSet()            // Xóa thành phố trùng nhau
                  .toList();          // Chuyển về list để render

              return DropdownButton<String?>(
                value: selectedCity,
                hint: const Text(
                  'All Cities',
                  style: TextStyle(color: Colors.white38, fontSize: 14),
                ),
                dropdownColor: const Color(0xFF1E293B),
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(color: Colors.white),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('All Cities'),
                  ),
                  ...cities.map((city) {
                    return DropdownMenuItem<String?>(
                      value: city,
                      child: Text(city),
                    );
                  }),
                ],
                onChanged: (value) {
                  ref.read(cityProvider.notifier).state = value;
                },
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.cyanAccent),
                ),
              ),
            ),
            error: (err, _) => const Text(
              'Error loading filter address',
              style: TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}