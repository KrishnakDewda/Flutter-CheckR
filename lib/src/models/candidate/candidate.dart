import 'package:flutter_checkr/flutter_checkr.dart';

class Candidate {
  final String? id;
  final DateTime? createdAt;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final DateTime? dob;
  final String? ssn;
  final String? email;
  final String? zipCode;
  final String? customId;
  final DateTime? updatedAt;
  final List<String> reportIds;
  final List<String> geoIds;

  const Candidate({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.middleName,
    this.dob,
    this.ssn,
    this.email,
    this.zipCode,
    this.customId,
    this.updatedAt,
    this.reportIds = const [],
    this.geoIds = const [],
  });

  factory Candidate.fromMap(Map<String, dynamic> map) {
    return Candidate(
      id: map['id'],
      createdAt: DateTime.tryParse(map['created_at']),
      firstName: map['first_name'],
      lastName: map['last_name'],
      middleName: map['middle_name'],
      dob: DateTime.tryParse(map['dob']),
      ssn: map['ssn'],
      email: map['email'],
      zipCode: map['zipcode'],
      customId: map['custom_id'],
      updatedAt: DateTime.tryParse(map['updated_at']),
      reportIds: List<String>.from(map['report_ids'].map((x) => x)),
      geoIds: List<String>.from(map['geo_ids'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'dob': dob != null ? CheckrUtils.toDateStringFormat(dob!) : '',
      'ssn': ssn,
      'email': email,
      'zipcode': zipCode,
      'no_middle_name': false,
      'updated_at': updatedAt,
      'report_ids': List<String>.from(reportIds.map((x) => x)),
      'geo_ids': List<String>.from(geoIds.map((x) => x)),
    };
  }
}
