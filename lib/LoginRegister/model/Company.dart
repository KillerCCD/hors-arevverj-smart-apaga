class Company {
  final String name;
  final String taxCode;
 

  Company({this.name, this.taxCode,});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        name: json['name'] ?? '',
        taxCode: json['taxCode'] ?? '',
       );
  }

  Map toMap() {
    return {
      'name': name ?? '',
      'taxCode': taxCode ?? '',
     
    };
  }
}
