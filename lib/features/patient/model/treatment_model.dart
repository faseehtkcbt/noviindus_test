import 'branch_model.dart';

class Treatment {
  final int id;
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final List<Branch> branches;

  Treatment({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.branches,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    var list = json['branches'] as List;
    List<Branch> branchesList = list.map((i) => Branch.fromJson(i)).toList();

    return Treatment(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      price: json['price'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      branches: branchesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'price': price,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'branches': branches.map((branch) => branch.toJson()).toList(),
    };
  }
}
