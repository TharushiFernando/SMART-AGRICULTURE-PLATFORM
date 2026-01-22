class LandModel{
  final String id;
  final String name;
  final String size;
  final double lat;
  final double lng;
  final String palmAgeYears;

  LandModel({
    required this.id,
    required this.name,
    required this.size,
    required this.lat,
    required this.lng,
    required this.palmAgeYears,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) {
    return LandModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        size: json['size'] ?? '',
        lat: (json['lat'] != null) ? json['lat'].toDouble() : null,
        lng: (json['lng'] != null) ? json['lng'].toDouble() : null,
        palmAgeYears: json['palmAgeYears'] ?? '');
  }

}