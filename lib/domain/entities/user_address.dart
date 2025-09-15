class UserAddress {
  String? state;
  String? city;
  String? street;
  String? number;
  String? neighborhood;
  String? complement;
  UserAddress({this.state, this.city, this.street, this.number, this.neighborhood, this.complement});

  UserAddress.empty() {
    state = null;
    city = null;
    street = null;
    number = null;
    neighborhood = null;
    complement = null;
  }

  UserAddress.fromJson(Map<String, dynamic> json)
    : state = json['state'] as String?,
      city = json['city'] as String?,
      street = json['street'] as String?,
      number = json['number'] as String?,
      neighborhood = json['neighborhood'] as String?,
      complement = json['complement'] as String?;

  Map<String, dynamic> toJson() {
    return {
      'state': state,
      'city': city,
      'street': street,
      'number': number,
      'neighborhood': neighborhood,
      'complement': complement,
    };
  }
}
