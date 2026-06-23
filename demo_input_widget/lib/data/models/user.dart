class User {
  final int id;
  final String name;
  final String username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  // --- CÁC THUỘC TÍNH BỔ SUNG PHỤC VỤ CHO BỘ LỌC UI ---
  final String? gender;      // 'Male' hoặc 'Female' (Dùng cho Radio)
  final int? age;            // Tuổi (Dùng cho Slider)
  final double? salary;      // Mức lương (Dùng cho RangeSlider)
  final DateTime? birthDate; // Ngày sinh nhật (Dùng cho DatePicker)
  final String? shiftStart;  // Giờ bắt đầu ca làm việc "HH:mm" (Dùng cho TimePicker)
  final String? shiftEnd;    // Giờ kết thúc ca làm việc "HH:mm" (Dùng cho TimePicker)
  final int? themeMode;      //Theme riêng của mỗi user (0: Tối, 1: Sáng) ---

  User({
    required this.id,
    required this.name,
    required this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
    this.gender,
    this.age,
    this.salary,
    this.birthDate,
    this.shiftStart,
    this.shiftEnd,
    this.themeMode
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // 1. KHAI BÁO BIẾN userId VÀ isEven TRƯỚC KHI SỬ DỤNG
    final userId = json['id'] as int? ?? 0;
    final isEven = userId % 2 == 0;

    return User(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String?,
      address: json['address'] != null ? Address.fromJson(json['address'] as Map<String, dynamic>) : null,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      company: json['company'] != null ? Company.fromJson(json['company'] as Map<String, dynamic>) : null,

      // Khởi tạo các thuộc tính lọc mới (ưu tiên lấy từ json, nếu không có sẽ tự mock)
      gender: json['gender'] as String? ?? (isEven ? 'Male' : 'Female'),
      age: json['age'] as int? ?? ((userId * 3) % 40 + 20), // Tạo tuổi ngẫu nhiên từ 20 đến 60
      salary: (json['salary'] is num)
          ? (json['salary'] as num).toDouble()
          : ((userId * 500) % 4000 + 1000).toDouble(), // Tạo lương ngẫu nhiên từ 1000$ đến 5000$

      // Sinh ngày sinh nhật ngẫu nhiên để test bộ lọc DatePicker
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : DateTime(1980 + (userId % 25), 1 + (userId % 12), 1 + (userId % 28)),

      // Phân chia ca làm việc (Id chẵn làm ca hành chính, lẻ làm ca chiều tối) để test TimePicker khoảng thời gian
      shiftStart: json['shiftStart'] as String? ?? (isEven ? "08:00" : "14:00"),
      shiftEnd: json['shiftEnd'] as String? ?? (isEven ? "17:00" : "22:00"),
      // Khởi tạo từ json, nếu không có mặc định gán là 0 (Dark Mode)
      themeMode: json['themeMode'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      if (email != null) 'email': email,
      if (address != null) 'address': address!.toJson(),
      if (phone != null) 'phone': phone,
      if (website != null) 'website': website,
      if (company != null) 'company': company!.toJson(),
      // Đóng gói các thuộc tính bộ lọc mới vào JSON
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (salary != null) 'salary': salary,
      if (birthDate != null) 'birthDate': birthDate!.toIso8601String(),
      if (shiftStart != null) 'shiftStart': shiftStart,
      if (shiftEnd != null) 'shiftEnd': shiftEnd,
      // Thêm vào Map json đóng gói gửi đi
      if (themeMode != null) 'themeMode': themeMode,
    };
  }
}

class Address {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String?,
      suite: json['suite'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      geo: json['geo'] != null ? Geo.fromJson(json['geo'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (street != null) 'street': street,
      if (suite != null) 'suite': suite,
      if (city != null) 'city': city,
      if (zipcode != null) 'zipcode': zipcode,
      if (geo != null) 'geo': geo!.toJson(),
    };
  }
}

class Geo {
  final String? lat;
  final String? lng;

  Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    };
  }
}

class Company {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String?,
      catchPhrase: json['catchPhrase'] as String?,
      bs: json['bs'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (catchPhrase != null) 'catchPhrase': catchPhrase,
      if (bs != null) 'bs': bs,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Company &&
            name == other.name &&
            catchPhrase == other.catchPhrase &&
            bs == other.bs;
  }

  @override
  int get hashCode =>
      Object.hash(name, catchPhrase, bs);
}