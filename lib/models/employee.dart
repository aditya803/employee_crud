class Employee {
  final String id;
  final String name;
  final String address;
  final String city;
  final String country;
  final String zipCode;
  final List<ContactMethod> contactMethods;

  Employee({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.contactMethods,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      zipCode: json['zipCode'],
      contactMethods: (json['contactMethods'] as List)
          .map((i) => ContactMethod.fromJson(i))
          .toList(),
    );
  }
}

class ContactMethod {
  final String contactMethod;
  final String value;

  ContactMethod({
    required this.contactMethod,
    required this.value,
  });

  factory ContactMethod.fromJson(Map<String, dynamic> json) {
    return ContactMethod(
      contactMethod: json['contact_method'],
      value: json['value'],
    );
  }
}
