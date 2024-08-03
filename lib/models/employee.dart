class Employee {
  String? id;
  final String name;
  final int zipCode;
  final String address;
  final String city;
  final String country;
  final Contact contact;

  Employee({
    this.id,
    required this.name,
    required this.zipCode,
    required this.address,
    required this.city,
    required this.country,
    required this.contact,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? '',  // default empty string if _id is not present
      name: json['name'] ?? '',
      zipCode: json['zipcode'] ?? 0,
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      contact: Contact.fromJson(json['contact'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'zipcode': zipCode,
      'address': address,
      'city': city,
      'country': country,
      'contact': contact.toJson(),
    };
  }
}

class Contact {
   String contactMethod;
   String number;

  Contact({
    required this.contactMethod,
    required this.number,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactMethod: json['contact_method'] ?? '',
      number: json['number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contact_method': contactMethod,
      'number': number,
    };
  }
}
