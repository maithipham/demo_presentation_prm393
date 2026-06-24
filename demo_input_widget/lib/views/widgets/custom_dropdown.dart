import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/input_viewmodel.dart';

class CustomDropdown extends ConsumerWidget {
  const CustomDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final city = ref.watch(cityProvider);
    // lightmode(An) thì text màu đen, darkmode thì text màu trắng
    final isLightTheme = ref.watch(isLightThemeProvider);

    // Danh sách các địa điểm lựa chọn bao gồm cả 'All'
    // Sử dụng Map để ánh xạ từ Giá trị hiển thị (UI) sang Giá trị dữ liệu (State)
    const citiesMap = {
      'All': null,
      'Ha Noi': 'Ha Noi',
      'Da Nang': 'Da Nang',
      'HCM': 'HCM',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- 1. DROPDOWN BUTTON THƯỜNG ---
        Text(
          'Address (Dropdown Button thường)',
          style: TextStyle(
            color: isLightTheme
                ? Colors.black87
                : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            // lightmode(An) thì text màu đen, darkmode thì text màu trắng
            color: isLightTheme
                ? Colors.white
                : const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isLightTheme
                ? Colors.black12
                : Colors.white10,),
          ),
          child: DropdownButton<String?>(
            value: city, // Giá trị hiện tại (có thể là null nếu chọn All)
            hint: Text(
              'Select Address',
              style: TextStyle(color: isLightTheme
                  ? Colors.black45
                  : Colors.white38, fontSize: 14),
            ),
            dropdownColor: const Color(0xFF1E293B),
            isExpanded: true,
            underline: const SizedBox(), // Ẩn gạch chân mặc định
            style: TextStyle(color: isLightTheme
                ? Colors.black87
                : Colors.white,),
            items: citiesMap.entries.map((entry) {
              return DropdownMenuItem<String?>(
                value: entry.value,
                child: Text(entry.key),
              );
            }).toList(),
            onChanged: (value) {
              ref.read(cityProvider.notifier).state = value;
            },
          ),
        ),

        const SizedBox(height: 20),

        // --- 2. DROPDOWN BUTTON FORM FIELD ---
         Text(
          'Address (Dropdown Form Field chuẩn)',
          style: TextStyle(
            color: isLightTheme
                ? Colors.black87
                : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String?>(
          value: city,
          // FIX (An): đổi màu dropdown theo theme
          dropdownColor: isLightTheme
              ? Colors.white
              : const Color(0xFF1E293B),
          style: TextStyle(
            color: isLightTheme
                ? Colors.black87
                : Colors.white,
          ),

          decoration: InputDecoration(
            labelText: 'City Address',
            // An: lightmode thì text màu đen, darkmode thì text màu trắng
            labelStyle: TextStyle(
              color: isLightTheme
                  ? Colors.black54
                  : Colors.white54,
              fontSize: 13,
            ),
            prefixIcon: const Icon(Icons.location_on, color: Colors.cyanAccent),
            filled: true,
            //An: lightmode thì text màu đen, darkmode thì text màu trắng
            fillColor: isLightTheme
                ? Colors.white
                : const Color(0xFF0F172A),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isLightTheme
                  ? Colors.black12
                  : Colors.white10,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.cyanAccent),
            ),
          ),
          //An: lightmode thì text màu đen, darkmode thì text màu trắng
          hint: Text(
            'Select Address',
            style: TextStyle(
              color: isLightTheme
                  ? Colors.black45
                  : Colors.white38,
            ),
          ),
          items: citiesMap.entries.map((entry) {
            return DropdownMenuItem<String?>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
          onChanged: (value) {
            ref.read(cityProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}