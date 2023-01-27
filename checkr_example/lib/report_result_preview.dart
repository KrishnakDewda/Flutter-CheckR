import 'package:flutter/material.dart';
import 'package:flutter_checkr/flutter_checkr.dart';

class ReportResultPreview extends StatelessWidget {
  final Report report;

  const ReportResultPreview({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Candidate: ${report.candidateId}')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: report.toMap().entries.map(
              (e) {
                return ListTile(
                  title: Text(e.key),
                  subtitle: Text(e.value.toString()),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
