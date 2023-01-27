import 'package:checkr_example/report_result_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_checkr/flutter_checkr.dart';

class CandidateForm extends StatefulWidget {
  const CandidateForm({super.key});

  @override
  State<CandidateForm> createState() => _CandidateFormState();
}

class _CandidateFormState extends State<CandidateForm> {
  //
  late Checkr _checkr;
  Candidate? _candidate;
  Invitation? _invitation;
  Report? _report;
  String? _geoId;

  bool _loading = false;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _ssn = TextEditingController();

  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _country = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkr = Checkr(
      environment: CheckrEnvironment.staging,
      secretKey: '010b38620b5fe0f55288db66e2a53b7390d8765a',
    );
  }

  Future<void> _onContinue() async {
    try {
      _setLoading(true);

      if (_geoId == null) {
        GeoCreateParams geoCreateParams = GeoCreateParams(
          name: _city.text,
          city: _city.text,
          state: _state.text,
          country: _country.text,
        );

        _geoId = await _checkr.createGeo(geoCreateParams);
      }

      CandidateCreateParams candidateCreateParams = CandidateCreateParams(
        firstName: _firstName.text,
        lastName: _lastName.text,
        email: _email.text,
        zipCode: _zipCode.text,
        dob: DateTime.parse(_dob.text),
        ssn: _ssn.text,
        geoIds: _geoId != null ? [_geoId!] : [],
      );

      _candidate = await _checkr.createCandidate(candidateCreateParams);

      if (_candidate != null) {
        InvitationCreateParams invitationCreateParams = InvitationCreateParams(
          package: CheckrPackage.basicPlusCriminal,
          candidateId: _candidate?.id ?? '',
          workLocations: [
            WorkLocation(
              city: _city.text,
              state: _state.text,
              country: _country.text,
            )
          ],
        );

        _invitation = await _checkr.createInvitation(invitationCreateParams);

        if (_invitation != null) {
          await _invitation?.launchInvitationUrl();
        }
      } else {
        _showSnackBar('Candidate not found');
      }
    } on CheckrException catch (e) {
      _showSnackBar(e.message);
    } finally {
      _setLoading(false);
    }
  }

  void _onCheckReport() async {
    try {
      _setLoading(true);
      _candidate = await _checkr.getCandidate(_candidate?.id);

      if (_candidate != null) {
        _report = await _checkr.getReport(_candidate?.reportIds.first);

        if (_report != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportResultPreview(report: _report!),
            ),
          );
        } else {
          _showSnackBar('Report not found');
        }
      } else {
        _showSnackBar('Candidate not found');
      }
    } on CheckrException catch (e) {
      _showSnackBar(e.message);
    } finally {
      _setLoading(false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Candidate Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstName,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _lastName,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _dob,
              decoration: const InputDecoration(hintText: 'Date of Birth'),
            ),
            TextField(
              controller: _ssn,
              decoration: const InputDecoration(hintText: 'SSN'),
            ),
            TextField(
              controller: _zipCode,
              decoration: const InputDecoration(hintText: 'Zip Code'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _city,
              decoration: const InputDecoration(hintText: 'City'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _state,
                    decoration: const InputDecoration(hintText: 'State'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _country,
                    decoration: const InputDecoration(hintText: 'Country'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            _loading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: _onContinue,
                        child: const Text('Continue'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                        ),
                        onPressed: _onCheckReport,
                        child: const Text('Check Report'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
