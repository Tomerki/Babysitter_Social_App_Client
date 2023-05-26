class Babysitter {
  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String eMail;
  String imageUrl;
  String address;
  String country;
  String aboutMe;
  double age;
  int wage;
  double minChildAge;
  double maxChildAge;
  int numOfChildren;
  bool comeToClient;
  bool inMyPlace;
  bool takeOutkindergarten;
  bool knowledgeFirstAid;
  bool houseworkHelper;
  bool outdoorActivities;
  bool driveLicense;
  bool changeDiaper;
  bool experienced;
  bool studiedEducation;

  Babysitter({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.age,
    required this.wage,
    required this.eMail,
    required this.imageUrl,
    required this.aboutMe,
    required this.country,
    required this.comeToClient,
    required this.inMyPlace,
    this.minChildAge = 1,
    this.maxChildAge = 15,
    this.numOfChildren = 5,
    this.takeOutkindergarten = false,
    this.knowledgeFirstAid = false,
    this.houseworkHelper = false,
    this.outdoorActivities = false,
    this.driveLicense = false,
    this.changeDiaper = false,
    this.experienced = false,
    this.studiedEducation = false,
  });
}
