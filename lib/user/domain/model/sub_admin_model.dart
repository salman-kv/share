class SubAdminModel {
  final String name;
  final String password;
  final int phone;
  final String imagePath;
  final String email;
  String? userId;
  int walletPrice;
  List<String>? hotels;

  SubAdminModel(
      {required this.walletPrice,
      required this.userId,
      required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.imagePath});

  Map<String, dynamic> toMaps() {
    return {
      "walletPrice": walletPrice,
      "email": email,
      "name": name,
      "password": password,
      "phone": phone,
      "image": imagePath
    };
  }

  static SubAdminModel fromMap(Map<String, dynamic> map, String userid) {
    return SubAdminModel(
        walletPrice: map["walletPrice"],
        userId: userid,
        email: map["email"],
        name: map["name"],
        password: map["password"],
        phone: map["phone"],
        imagePath: map["image"]);
  }
}
