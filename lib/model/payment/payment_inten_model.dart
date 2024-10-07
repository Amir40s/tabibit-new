class PaymentIntentModel {
  final String id;
  final String object;
  final int amount;
  final int amountCapturable;
  final int amountReceived;
  final String? clientSecret;
  final String currency;
  final String? description;
  final String? status;
  final Shipping? shipping;

  PaymentIntentModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCapturable,
    required this.amountReceived,
    this.clientSecret,
    required this.currency,
    this.description,
    this.status,
    this.shipping,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'] ?? '',
      object: json['object'] ?? '',
      amount: json['amount'] ?? 0,
      amountCapturable: json['amount_capturable'] ?? 0,
      amountReceived: json['amount_received'] ?? 0,
      clientSecret: json['client_secret'],
      currency: json['currency'] ?? '',
      description: json['description'],
      status: json['status'],
      shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
    );
  }
}

class Shipping {
  final Address? address;
  final String? name;
  final String? phone;

  Shipping({this.address, this.name, this.phone});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      name: json['name'],
      phone: json['phone'],
    );
  }
}

class Address {
  final String? city;
  final String? country;
  final String? line1;
  final String? line2;
  final String? postalCode;
  final String? state;

  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      country: json['country'],
      line1: json['line1'],
      line2: json['line2'],
      postalCode: json['postal_code'],
      state: json['state'],
    );
  }
}
