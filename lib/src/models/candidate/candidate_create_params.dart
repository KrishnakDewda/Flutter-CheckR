import 'package:flutter_checkr/src/helpers/checkr_utils.dart';

class CandidateCreateParams {
  final String firstName;
  final String lastName;
  final String email;
  final String? middleName;
  final String zipCode;
  final DateTime dob;
  final String ssn;
  final String? customId;
  final List<String> geoIds;

  CandidateCreateParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.zipCode,
    required this.dob,
    required this.ssn,
    this.customId,
    this.middleName,
    required this.geoIds,
  }) : assert(CheckrUtils.isEmailValid(email), 'Invalid Email');

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'email': email,
      'no_middle_name': middleName == null,
      'zipcode': zipCode,
      'dob': CheckrUtils.toDateStringFormat(dob),
      'ssn': ssn,
      'custom_id': customId,
      'geo_ids': geoIds,
    };
  }
}
