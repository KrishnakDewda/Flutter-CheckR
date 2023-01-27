class GeoCreateParams {
  final String name;
  final String city;
  final String state;
  final String country;

  GeoCreateParams({
    required this.name,
    required this.city,
    required this.state,
    required this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'state': state,
      'country': country,
    };
  }
}
