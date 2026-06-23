import 'package:demo_input_widget/views/widgets/checkbox_radio_switch.dart';
import 'package:demo_input_widget/views/widgets/custom_date_picker.dart';
import 'package:demo_input_widget/views/widgets/custom_dropdown.dart';
import 'package:demo_input_widget/views/widgets/custom_slider.dart';
import 'package:demo_input_widget/views/widgets/user_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user.dart';
import '../viewmodels/input_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart';

class UserView extends ConsumerWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListAsync = ref.watch(userViewModelProvider);
// Đọc toàn bộ trạng thái bộ lọc từ input_viewmodel
    final searchQuery = ref.watch(nameProvider).toLowerCase();
    final selectedCity = ref.watch(cityProvider);
    final onlyWithEmail = ref.watch(notificationProvider);
    final currentAgeFilter = ref.watch(ageProvider);
    final salaryRange = ref.watch(salaryProvider);
    final selectedGender = ref.watch(genderProvider);
    final isHiddenEmail = ref.watch(agreeProvider);
    final filterDate = ref.watch(selectedDateProvider);
    final filterTime = ref.watch(selectedTimeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Modern dark slate background
      appBar: AppBar(
        title: const Text(
          'User Directory (CRUD Demo)',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.cyanAccent),
            onPressed: () => ref.read(userViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== 1. THANH BÊN TRÁI: SIDEBAR FILTER ====================
          Container(
            width: 340,
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              border: Border(right: BorderSide(color: Colors.white10)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FILTERS PANEL',
                    style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Divider(color: Colors.white24, height: 24),

        // 1. DROPDOWN + DROPDOWNFORMFIELD
                  const CustomDropdown(),
                  const Divider(color: Colors.white10, height: 32),

        // 2. CHECKBOX + RADIO + SWITCH
                  const CheckboxRadioSwitch(),
                  const Divider(color: Colors.white10, height: 32),

        // 3. SLIDER + RANGESLIDER
                  const CustomSliderWidget(),
                  const Divider(color: Colors.white10, height: 32),

        // 4. DATEPICKER + TIMEPICKER
                  const CustomDatePicker(),
                ],
              ),
            ),
          ),
      // ==================== 2. Ở GIỮA & BÊN PHẢI: TRÊN SEARCH, DƯỚI LIST ====================
      Expanded(
        child: Column(
          children: [
            // THANH SEARCH TRÊN CÙNG
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF0F172A),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search user by name or username...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.cyanAccent)),
                ),
                onChanged: (value) => ref.read(nameProvider.notifier).state = value,
              ),
            ),
              Expanded(
                child: userListAsync.when(
                  data: (users) {
                    // BƯỚC 1: Lấy các giá trị đang nhập từ các ô lọc trên UI
                    final searchQuery = ref.watch(nameProvider).toLowerCase();
                    final selectedCity = ref.watch(cityProvider);
                    final onlyWithEmail = ref.watch(notificationProvider);

                    // BƯỚC 2: Thực hiện lọc mảng dữ liệu users gốc dựa trên điều kiện bạn muốn
                    final filteredUsers = users.where((user) {
                      // Lọc theo ký tự tìm kiếm của TextField (Tìm cả Name và Username)
                      final matchesSearch = user.name.toLowerCase().contains(searchQuery) ||
                          user.username.toLowerCase().contains(searchQuery);

                      // Lọc theo Thành phố được chọn từ Dropdown (Nếu chưa chọn dropdown thì bỏ qua)
                      final matchesCity = selectedCity == null ||
                          (user.address?.city == selectedCity);

                      // Lọc theo nút Switch (Nếu bật switch thì chỉ giữ lại các user có email)
                      final matchesEmail = !onlyWithEmail || (user.email != null && user.email!.isNotEmpty);


                      // Lọc theo Slider: Lấy ra người dùng có ID < currentAgeFilter
                      final matchesAge = user.id < currentAgeFilter;
                      // Lọc theo RangeSlider: Lấy ra người dùng theo ID từ salaryRange.start đến salaryRange.end
                      final matchesSalary = user.id >= salaryRange.start && user.id <= salaryRange.end;

                      final matchesDate =
                          filterDate == null ||
                              (user.birthDate != null &&
                                  user.birthDate!.year == filterDate.year &&
                                  user.birthDate!.month == filterDate.month &&
                                  user.birthDate!.day == filterDate.day);
                      final selectedTimeString =
                      filterTime == null
                          ? null
                          : '${filterTime.hour.toString().padLeft(2, '0')}:'
                          '${filterTime.minute.toString().padLeft(2, '0')}';

                      final matchesTime =
                          selectedTimeString == null ||
                              user.shiftStart == selectedTimeString;


                      return matchesSearch &&
                          matchesCity &&
                          matchesEmail &&
                          matchesAge &&
                          matchesSalary &&
                          matchesDate &&
                          matchesTime;
                    }).toList();
                    //

                    if (filteredUsers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No users found.',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () => ref.read(userViewModelProvider.notifier).refresh(),
                      color: Colors.cyanAccent,
                      backgroundColor: const Color(0xFF1E293B),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          return _buildUserCard(context, ref, user, isHiddenEmail);
                        },
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                    ),
                  ),
                  error: (err, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          'Error: $err',
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: const Color(0xFF0F172A),
                          ),
                          onPressed: () => ref.read(userViewModelProvider.notifier).refresh(),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUserDialog(context, ref),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: const Color(0xFF0F172A),
        icon: const Icon(Icons.add),
        label: const Text('Add User'),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, WidgetRef ref, User user, bool isHiddenEmail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.cyanAccent.withAlpha(25),
          child: Text(
            user.name.isNotEmpty ? user.name.substring(0, 2).toUpperCase() : 'US',
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withAlpha(40),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'ID: ${user.id}',
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                user.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text(
              '@${user.username}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),

            Text(
              'Birth: ${user.birthDate}',
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 12,
              ),
            ),

            Text(
              'Shift: ${user.shiftStart} - ${user.shiftEnd}',
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 12,
              ),
            ),

            if (user.email != null) ...[
              const SizedBox(height: 2),
              Text(
                isHiddenEmail
                    ? '********@gmail.com'
                    : user.email!,
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 12,
                  fontStyle: isHiddenEmail
                      ? FontStyle.italic
                      : FontStyle.normal,
                ),
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.amberAccent),
              onPressed: () => _showUserDialog(context, ref, user: user),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () => _deleteUser(context, ref, user),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserDialog(BuildContext context, WidgetRef ref, {User? user}) {
    final nameController = TextEditingController(text: user?.name ?? '');
    final usernameController = TextEditingController(text: user?.username ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');

    // 1. TẠO KEY ĐỂ QUẢN LÝ FORM VALIDATION
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            user == null ? 'Add New User' : 'Edit User',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(nameController, 'Name (Required)', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(usernameController, 'Username (Required)', Icons.alternate_email),
                  const SizedBox(height: 16),
                  _buildTextField(emailController, 'Email (Optional)', Icons.email_outlined),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: const Color(0xFF0F172A),
              ),
              onPressed: () async {
                final name = nameController.text.trim();
                final username = usernameController.text.trim();
                final email = emailController.text.trim();

                if (name.isEmpty || username.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all required fields')),
                  );
                  return;
                }
                // 3. THAY THẾ ĐOẠN IF CHECK CŨ BẰNG FORM VALIDATION
                // Nếu các TextFormField báo có lỗi (trống dữ liệu), hàm sẽ dừng lại tại đây và tự hiện viền đỏ
                // if (!formKey.currentState!.validate()) {
                //   return;
                // }

                Navigator.pop(context);

                try {
                  if (user == null) {
                    // Create new user (Generate arbitrary ID for mock purpose)
                    final newCreatedUser = User(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: name,
                      username: username,
                      email: email.isNotEmpty ? email : null,
                    );
                    await ref.read(userViewModelProvider.notifier).addUser(newCreatedUser);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User added successfully!')),
                      );
                    }
                  } else {
                    // Update existing user
                    final updatedUser = User(
                      id: user.id,
                      name: name,
                      username: username,
                      email: email.isNotEmpty ? email : null,
                      address: user.address,
                      phone: user.phone,
                      website: user.website,
                      company: user.company,
                      // Truyền tiếp các thuộc tính sang để không bị mất dữ liệu cũ
                      gender: user.gender,
                      age: user.age,
                      salary: user.salary,
                      birthDate: user.birthDate,
                      shiftStart: user.shiftStart,
                      shiftEnd: user.shiftEnd,
                      themeMode: user.themeMode, // Giữ nguyên cấu hình theme cũ của họ
                    );
                    await ref.read(userViewModelProvider.notifier).updateUser(updatedUser);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User updated successfully!')),
                      );
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Operation failed: $e')),
                    );
                  }
                }
              },
              child: Text(user == null ? 'Create' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isRequired = true}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      // Thêm chức năng Validator của TextFormField
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return '$label is required'; // Trả về câu thông báo lỗi
        }
        return null; // Không có lỗi
      },

      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.cyanAccent),
        filled: true,
        fillColor: const Color(0xFF0F172A),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withAlpha(25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.cyanAccent),
        ),
        // Thêm hiển thị viền đỏ khi có lỗi validation
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
    );
  }

  void _deleteUser(BuildContext context, WidgetRef ref, User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete User', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete ${user.name}?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ref.read(userViewModelProvider.notifier).deleteUser(user.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User deleted successfully!')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete user: $e')),
          );
        }
      }
    }
  }
}