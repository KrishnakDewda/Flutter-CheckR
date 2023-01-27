enum CheckrPackage {
  educationVerification(
    name: 'Education Verification',
    value: 'checkrdirect_education_verification',
  ),
  essentialCriminal(
    name: 'Essential Criminal',
    value: 'checkrdirect_essential_criminal',
  ),
  basicPlusCriminal(
    name: 'Basic Plus Criminal',
    value: 'checkrdirect_basic_plus_criminal',
  ),
  motorVehicleReport(
    name: 'Motor Vehicle Report',
    value: 'motor_vehicle_report',
  ),
  internationalBasicPlus(
    name: 'International Basic Plus',
    value: 'checkrdirect_international_basic_plus',
  ),
  professionalCriminal(
    name: 'Professional Criminal',
    value: 'checkrdirect_professional_criminal',
  ),
  currentEmployerVerification(
    name: 'Current Employer Verification',
    value: 'checkrdirect_current_employer_verification',
  ),
  previousEmploymentVerification(
    name: 'Previous Employment Verification',
    value: 'checkrdirect_previous_employment_verification',
  ),
  internationalProfessionalPlus(
    name: 'International Professional Plus',
    value: 'checkrdirect_international_professional_plus',
  ),
  internationalProfessional(
    name: 'International Professional',
    value: 'checkrdirect_international_professional',
  );

  final String name;
  final String value;

  const CheckrPackage({required this.name, required this.value});
}

enum ReportStatus { pending, complete }

enum ReportResult { unknown, clear, consider }

enum CheckrEnvironment {
  staging('https://api.checkr-staging.com/v1'),
  production('https://api.checkr.com/v1');

  final String baseUrl;

  const CheckrEnvironment(this.baseUrl);
}
