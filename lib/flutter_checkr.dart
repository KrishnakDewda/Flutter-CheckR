library flutter_checkr;

import 'package:dio/dio.dart';
import 'package:flutter_checkr/flutter_checkr.dart';
import 'package:flutter_checkr/src/helpers/checkr_client.dart';

export 'src/models/invitation/invitation.dart';
export 'src/models/invitation/invitation_create_params.dart';

export 'src/models/candidate/candidate.dart';
export 'src/models/candidate/candidate_create_params.dart';

export 'src/models/report/report.dart';

export 'src/models/geo/geo_create_params.dart';

export 'src/helpers/checkr_utils.dart';
export 'src/helpers/enums.dart';
export 'src/helpers/checkr_utils.dart';
export 'src/helpers/checkr_exception.dart';
export 'src/helpers/url_launcher.dart';

class Checkr {
  final CheckrEnvironment environment;
  final String secretKey;
  final CheckrClient _client;

  Checkr({required this.environment, required this.secretKey})
      : _client = CheckrClient(environment: environment, secretKey: secretKey);

  Future<Candidate> createCandidate(CandidateCreateParams params) async {
    Response<dynamic> response = await _client.request(
      method: 'POST',
      path: '/candidates',
      data: params.toMap(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Candidate.fromMap(response.data);
    } else {
      throw _throwCheckrException(response.data);
    }
  }

  Future<Candidate> getCandidate(String? candidateId) async {
    Response<dynamic> response = await _client.request(
      method: 'GET',
      path: '/candidates/$candidateId',
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Candidate.fromMap(response.data);
    } else {
      throw _throwCheckrException(response.data);
    }
  }

  Future<String> createGeo(GeoCreateParams params) async {
    Response<dynamic> response = await _client.request(
      method: 'POST',
      path: '/geos',
      data: params.toMap(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.data['id'];
    } else {
      throw _throwCheckrException(response.data);
    }
  }

  Future<Invitation> createInvitation(InvitationCreateParams params) async {
    Response<dynamic> response = await _client.request(
      method: 'POST',
      path: '/invitations',
      data: params.toMap(),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Invitation.fromMap(response.data);
    } else {
      throw _throwCheckrException(response.data);
    }
  }

  Future<Invitation> getInvitation(String? invitationId) async {
    Response<dynamic> response = await _client.request(
      method: 'GET',
      path: '/invitations/$invitationId',
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Invitation.fromMap(response.data);
    } else {
      throw _throwCheckrException(response.data);
    }
  }

  Future<Report> getReport(String? reportId) async {
    Response<dynamic> response = await _client.request(
      method: 'GET',
      path: '/reports/$reportId',
    );

    if (response.statusCode == 200) {
      return Report.fromMap(response.data);
    } else {
      throw _throwCheckrException(response.data);
    }
  }

  CheckrException _throwCheckrException(dynamic data) {
    late String message;
    if (data['error'] is List) {
      List<String> error = List<String>.from(data['error']);
      message = error.first;
    } else if (data['error'] is String) {
      message = data['error'];
    }
    return CheckrException(message);
  }
}
