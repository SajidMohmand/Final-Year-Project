class Lawyer {
  final String id;
  final String name;
  final String domain;
  final String image;
  final String rating;
  final int complaintNum;

  Lawyer({
    required this.id,
    required this.name,
    required this.domain,
    required this.image,
    required this.rating,
    required this.complaintNum,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'domain': domain,
      'image': image,
      'rating': rating,
      'complaintNum': complaintNum,
    };
  }
}
