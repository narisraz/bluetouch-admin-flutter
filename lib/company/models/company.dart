class Company {
  final String? id;
  final String name;

  Company({this.id, required this.name});

  static Company fromJson(Map<String, dynamic> data) {
    return Company(name: data['name'], id: data['id']);
  }
}
