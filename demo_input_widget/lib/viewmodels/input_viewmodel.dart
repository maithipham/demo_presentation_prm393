import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<String>((ref) => '');

final emailProvider = StateProvider<String>((ref) => '');

final cityProvider = StateProvider<String?>((ref) => null);

final agreeProvider = StateProvider<bool>((ref) => false);

final genderProvider = StateProvider<String>((ref) => 'All');

final notificationProvider = StateProvider<bool>((ref) => false);
// An dart/light mode theme provider
final isLightThemeProvider = StateProvider<bool>((ref) => false);

final ageProvider = StateProvider<double>((ref) => 11);

final salaryProvider = StateProvider<RangeValues>(
      (ref) => const RangeValues(1, 10),
);

final selectedDateProvider = StateProvider<DateTime?>(
      (ref) => null,
);

final selectedTimeProvider = StateProvider<TimeOfDay?>(
      (ref) => null,
);