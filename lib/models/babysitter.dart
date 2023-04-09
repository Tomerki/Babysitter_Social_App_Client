enum Flexibility {
  ComeToClient,
  AtMyPlace,
  ClientDecides,
}

class Babysitter {
  String firstName;
  String lastName;
  String phoneNumber;
  String eMail;
  String imageUrl;
  String address;
  String country;
  double age;
  Flexibility flexibility;

  Babysitter({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.age,
    required this.eMail,
    required this.imageUrl,
    required this.country,
    required this.flexibility,
  });
}
