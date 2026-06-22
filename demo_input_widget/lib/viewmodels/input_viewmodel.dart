import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<String>((ref) => '');

final emailProvider = StateProvider<String>((ref) => '');

final cityProvider = StateProvider<String?>((ref) => null);

final agreeProvider = StateProvider<bool>((ref) => false);

final genderProvider = StateProvider<String>((ref) => 'All');

final notificationProvider = StateProvider<bool>((ref) => false);

final ageProvider = StateProvider<double>((ref) => 100);

final salaryProvider = StateProvider<RangeValues>(
      (ref) => const RangeValues(0, 10000),
);

final selectedDateProvider = StateProvider<DateTime?>(
      (ref) => null,
);

final selectedTimeProvider = StateProvider<TimeOfDay?>(
      (ref) => null,
);