class NotificationNewDriver {

  NotificationNewDriver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.identityNumber,
    required this.phoneNumber,
    required this.licenceType,
    required this.email,
    // required this.contractType,
     this.submissionDate,
    required this.valid,
    required this.identityLink

});

  String identityLink;

  String id;
  String firstName;
  String lastName;
  String birthDate;
  int identityNumber;
  int phoneNumber;
  String licenceType;
  String email;
  // String contractType;
  bool valid;
  String? submissionDate;

}