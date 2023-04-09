enum Flexibility {
  ComeToNanny,
  AtMyPlace,
  DoesntMatter,
}

class Parent {
  String firstName;
  String lastName;
  String address;
  String eMail;
  String phoneNumber;
  Flexibility flexibility;

  Parent({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.eMail,
    required this.phoneNumber,
    required this.flexibility,
  });
}
