import 'package:flutter_checkr/flutter_checkr.dart';
import 'package:collection/collection.dart';

class Report {
  final String? id;
  final ReportStatus? status;
  final DateTime? createdAt;
  final DateTime? completedAt;
  final int turnaroundTime;
  final DateTime? dueTime;
  final CheckrPackage? package;
  final DateTime? estimatedCompletionTime;
  final ReportResult? result;
  final List<WorkLocation> workLocations;
  final String? candidateId;
  final List<String> geoIds;

  Report({
    this.id,
    this.status,
    this.createdAt,
    this.completedAt,
    this.dueTime,
    this.package,
    this.estimatedCompletionTime,
    this.result,
    this.candidateId,
    this.turnaroundTime = 0,
    this.workLocations = const [],
    this.geoIds = const [],
  });

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      status:
          ReportStatus.values.firstWhereOrNull((e) => e.name == map['status']),
      createdAt: DateTime.tryParse(map['created_at']),
      completedAt: DateTime.tryParse(map['completed_at']),
      turnaroundTime: map['turnaround_time'],
      dueTime: DateTime.tryParse(map['due_time']),
      package: CheckrPackage.values
          .firstWhereOrNull((e) => e.value == map['package']),
      estimatedCompletionTime:
          DateTime.tryParse(map['estimated_completion_time']),
      result: ReportResult.values
              .firstWhereOrNull((e) => e.name == map['result']) ??
          ReportResult.unknown,
      workLocations: List<WorkLocation>.from(
          map['work_locations'].map((x) => WorkLocation.fromMap(x))),
      candidateId: map['candidate_id'],
      geoIds: List<String>.from(map['geo_ids'].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status?.name,
      'created_at': createdAt,
      'completed_at': completedAt,
      'turnaround_time': turnaroundTime,
      'due_time': dueTime,
      'package': package?.value,
      'estimated_completion_time': estimatedCompletionTime,
      'result': result?.name,
      'work_locations': List<dynamic>.from(workLocations.map((x) => x.toMap())),
      'candidate_id': candidateId,
      'geo_ids': List<dynamic>.from(geoIds.map((x) => x)),
    };
  }

  bool get isVerifed {
    return status == ReportStatus.complete && result != ReportResult.unknown;
  }
}
