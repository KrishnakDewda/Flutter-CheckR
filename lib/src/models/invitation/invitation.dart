import 'package:flutter_checkr/flutter_checkr.dart';
import 'package:collection/collection.dart';

class Invitation {
  final String? id;
  final ReportStatus? status;
  final String? invitationUrl;
  final String? package;
  final DateTime? createdAt;
  final DateTime? expiresAt;
  final String? candidateId;

  Invitation({
    this.id,
    this.status,
    this.invitationUrl,
    this.package,
    this.createdAt,
    this.expiresAt,
    this.candidateId,
  });

  factory Invitation.fromMap(Map<String, dynamic> map) {
    return Invitation(
      id: map['id'],
      status:
          ReportStatus.values.firstWhereOrNull((e) => e.name == map['status']),
      invitationUrl: map['invitation_url'],
      package: map['package'],
      createdAt: DateTime.tryParse(map['created_at']),
      expiresAt: DateTime.tryParse(map['expires_at']),
      candidateId: map['candidate_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status?.name,
      'invitation_url': invitationUrl,
      'package': package,
      'created_at': createdAt,
      'expires_at': expiresAt,
      'candidate_id': candidateId,
    };
  }

  Future<void> launchInvitationUrl() async {
    if (invitationUrl != null) {
      await UrlLauncher.openInternally(invitationUrl!);
    }
  }
}
