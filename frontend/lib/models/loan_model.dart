class LoanModel {
  String id;
  String userId;
  double amount;
  int tenure;
  String purpose;
  String status;
  double? approvedAmount;
  DateTime? disbursedDate;
  DateTime createdAt;
  DateTime updatedAt;

  LoanModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.tenure,
    required this.purpose,
    required this.status,
    this.approvedAmount,
    this.disbursedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  // ✅ Factory to parse from JSON
  factory LoanModel.fromJson(Map<String, dynamic> json) {
    return LoanModel(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      tenure: (json['tenure'] ?? 0).toInt(),
      purpose: json['purpose'] ?? 'Personal',
      status: json['status'] ?? 'Submitted',
      approvedAmount: json['approvedAmount'] != null
          ? (json['approvedAmount'] as num).toDouble()
          : null,
      disbursedDate: json['disbursedDate'] != null
          ? DateTime.parse(json['disbursedDate'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // ✅ Convert to JSON (optional, for sending updates)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'amount': amount,
      'tenure': tenure,
      'purpose': purpose,
      'status': status,
      'approvedAmount': approvedAmount,
      'disbursedDate': disbursedDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
