class Profile {
  String id;
  String? bio;
  String? gender;
  String? country;
  String? city;
  String? selectedAvailability;

  // Education as a list of maps (for Bachelor's & Master's)
  List<Map<String, String>> education;

  // Experiences
  List<Map<String, String>> experiences;

  // Selected Domains
  List<String> selectedDomains;

  Profile({
    required this.id,
    this.bio,
    this.gender,
    this.country,
    this.city,
    this.selectedAvailability,
    List<Map<String, String>>? education,
    List<Map<String, String>>? experiences,
    List<String>? selectedDomains,
  })  : education = education ?? [],
        experiences = experiences ?? [],
        selectedDomains = selectedDomains ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bio': bio,
      'gender': gender,
      'country': country,
      'city': city,
      'selectedAvailability': selectedAvailability,
      'education': education,
      'experiences': experiences,
      'selectedDomains': selectedDomains,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      bio: map['bio'],
      gender: map['gender'],
      country: map['country'],
      city: map['city'],
      selectedAvailability: map['selectedAvailability'],
      education: List<Map<String, String>>.from(map['education'] ?? []),
      experiences: List<Map<String, String>>.from(map['experiences'] ?? []),
      selectedDomains: List<String>.from(map['selectedDomains'] ?? []),
    );
  }

  void addEducation(String level, String field, String university, String year) {
    education.add({
      'level': level, // "Bachelor" or "Master"
      'field': field,
      'university': university,
      'year': year,
    });
  }
}
