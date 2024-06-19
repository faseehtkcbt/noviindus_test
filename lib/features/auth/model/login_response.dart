class LoginResponse {
  final bool status;
  final String message;
  final String token;
  final bool isSuperuser;
  final UserDetails userDetails;

  LoginResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.isSuperuser,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      isSuperuser: json['is_superuser'],
      userDetails: UserDetails.fromJson(json['user_details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'token': token,
      'is_superuser': isSuperuser,
      'user_details': userDetails.toJson(),
    };
  }
}

class UserDetails {
  final int id;
  final String? lastLogin;
  final String name;
  final String phone;
  final String address;
  final String mail;
  final String username;
  final String password;
  final String passwordText;
  final int admin;
  final bool isAdmin;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? branch;

  UserDetails({
    required this.id,
    this.lastLogin,
    required this.name,
    required this.phone,
    required this.address,
    required this.mail,
    required this.username,
    required this.password,
    required this.passwordText,
    required this.admin,
    required this.isAdmin,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.branch,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      lastLogin: json['last_login'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      mail: json['mail'],
      username: json['username'],
      password: json['password'],
      passwordText: json['password_text'],
      admin: json['admin'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_login': lastLogin,
      'name': name,
      'phone': phone,
      'address': address,
      'mail': mail,
      'username': username,
      'password': password,
      'password_text': passwordText,
      'admin': admin,
      'is_admin': isAdmin,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'branch': branch,
    };
  }
}
