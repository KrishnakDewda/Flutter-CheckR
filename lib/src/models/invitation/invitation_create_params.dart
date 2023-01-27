import 'package:flutter_checkr/src/helpers/enums.dart';

class InvitationCreateParams {
  final CheckrPackage package;
  final String candidateId;
  final List<WorkLocation> workLocations;

  InvitationCreateParams({
    required this.package,
    required this.candidateId,
    required this.workLocations,
  });

  Map<String, dynamic> toMap() {
    return {
      'package': package.value,
      'candidate_id': candidateId,
      'work_locations':
          List<Map<String, dynamic>>.from(workLocations.map((x) => x.toMap())),
    };
  }
}

class WorkLocation {
  final String city;
  final String state;
  final String country;

  WorkLocation({
    required this.city,
    required this.state,
    required this.country,
  });

  factory WorkLocation.fromMap(Map<String, dynamic> map) {
    return WorkLocation(
      city: map['city'],
      state: map['state'],
      country: map['country'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'city': city, 'state': state, 'country': country};
  }
}
