class Member {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String plan;
  final DateTime? joiningDate;
  final DateTime? membershipExpiryDate;
  final String paymentStatus; // "Paid" or "Due"
  final String membershipStatus; // "Active" or "Expired"

  Member({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.plan,
    this.joiningDate,
    this.membershipExpiryDate,
    this.paymentStatus = "Paid",
    this.membershipStatus = "Active",
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      plan: json['plan'],
      joiningDate: json['joiningDate'] != null ? DateTime.parse(json['joiningDate']) : null,
      membershipExpiryDate: json['membershipExpiryDate'] != null ? DateTime.parse(json['membershipExpiryDate']) : null,
      paymentStatus: json['paymentStatus'] ?? "Paid",
      membershipStatus: json['membershipStatus'] ?? "Active",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'plan': plan,
      'joiningDate': joiningDate?.toIso8601String(),
      'membershipExpiryDate': membershipExpiryDate?.toIso8601String(),
      'paymentStatus': paymentStatus,
      'membershipStatus': membershipStatus,
    };
  }
}
