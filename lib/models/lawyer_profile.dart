class Profile {
  String? bio;
  String? gender;
  String? country;
  String? city;
  List<Map<String, dynamic>> education;
  List<Map<String, String>> experiences;
  List<Map<String, dynamic>> resolveCases; // Storing resolved cases as a map
  List<String> selectedDomains;

  Profile({
    this.bio,
    this.gender,
    this.country,
    this.city,
    List<Map<String, dynamic>>? education,
    List<Map<String, String>>? experiences,
    List<Map<String, dynamic>>? resolveCases,
    List<String>? selectedDomains,
  })  : education = education ?? [],
        experiences = experiences ?? [],
        resolveCases = resolveCases ?? [],
        selectedDomains = selectedDomains ?? [];

  // Convert to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'bio': bio,
      'gender': gender,
      'country': country,
      'city': city,
      'education': education,
      'experiences': experiences,
      'resolveCases': resolveCases,
      'selectedDomains': selectedDomains,
    };
  }

  // Create from Firestore document
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      bio: map['bio'],
      gender: map['gender'],
      country: map['country'],
      city: map['city'],
      education: (map['education'] is List)
          ? List<Map<String, dynamic>>.from(map['education'])
          : [],
      experiences: (map['experiences'] is List)
          ? List<Map<String, String>>.from(map['experiences'])
          : [],
      resolveCases: (map['resolveCases'] is List)
          ? List<Map<String, dynamic>>.from(map['resolveCases'])
          : [],
      selectedDomains: (map['selectedDomains'] is List)
          ? List<String>.from(map['selectedDomains'])
          : [],
    );
  }

}
