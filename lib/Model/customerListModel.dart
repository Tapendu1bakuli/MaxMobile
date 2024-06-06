class CustomerListModel {
  final String image;
  final String name;
  final String mobile;
  final String email;
  final String geoAddress;

  CustomerListModel({
    required this.image,
    required this.name,
    required this.mobile,
    required this.email,
    required this.geoAddress,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    return CustomerListModel(
      image: json['image'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      geoAddress: json['geo_address'],
    );
  }
}
