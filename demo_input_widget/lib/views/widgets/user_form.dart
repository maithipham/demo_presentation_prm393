// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../viewmodels/input_viewmodel.dart';
//
// class UserForm extends ConsumerWidget {
//   const UserForm({super.key});
//
//   @override
//   Widget build(
//       BuildContext context,
//       WidgetRef ref,
//       ) {
//     final agree = ref.watch(agreeProvider);
//     final gender = ref.watch(genderProvider);
//     final notification = ref.watch(notificationProvider);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Search & Filters',
//           style: TextStyle(
//             fontSize: 18, fontWeight: FontWeight.bold,
//           ),
//         ),
//
//         const SizedBox(height: 16),
//
//         // TextField
//         TextField(
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Search Name or Username...',
//             prefixIcon: Icon(Icons.search),
//           ),
//           onChanged: (value) {
//             ref.read(nameProvider.notifier).state = value;
//           },
//         ),
//
//         const SizedBox(height: 16),
//
//
//         const SizedBox(height: 24),
//         const Divider(),
//
//         const Text(
//           'Filters',
//           style: TextStyle(
//             fontSize: 18, fontWeight: FontWeight.bold,
//           ),
//         ),
//         // CheckboxListTile
//         CheckboxListTile(
//           title: const Text('Agree Terms'),
//           value: agree,
//           onChanged: (value) {
//             ref.read(agreeProvider.notifier).state = value ?? false;
//           },
//         ),
//
//         const Divider(),
//
//         const Text(
//           'Radio Button',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // RadioListTile
//         RadioListTile<String>(
//           title: const Text('Male'),
//           value: 'Male',
//           groupValue: gender,
//           onChanged: (value) {
//             ref.read(genderProvider.notifier).state = value!;
//           },
//         ),
//         // RadioListTile
//         RadioListTile<String>(
//           title: const Text('Female'),
//           value: 'Female',
//           groupValue: gender,
//           onChanged: (value) {
//             ref.read(genderProvider.notifier).state = value!;
//           },
//         ),
//
//         const Divider(),
//
//         const Text(
//           'Switch',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // SwitchListTile
//         SwitchListTile(
//           title: const Text('Hiển thị email'),
//           value: notification,
//           onChanged: (value) {
//             ref.read(notificationProvider.notifier).state = value;
//           },
//         ),
//       ],
//     );
//   }
// }