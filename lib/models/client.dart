class Client {
  final String id;
  final String name;
  final String phone;
  final String image;
  final int complaintNum;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.complaintNum,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'complaintNum': complaintNum,
    };
  }
}
