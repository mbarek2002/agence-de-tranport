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
     this.submissionDate,
    required this.valid,
    required this.driverImage,
    required this.identityCardImageFace1,
    required this.identityCardImageFace2,
    required this.licenceImageFace1,
    required this.licenceImageFace2,
    required this.password,
    this.moreImage1,
    this.moreImage2,
    this.moreImage3
});
  String driverImage;
  String id;
  String firstName;
  String lastName;
  String birthDate;
  int identityNumber;
  int phoneNumber;
  String licenceType;
  String email;
  bool valid;
  String? submissionDate;
  String identityCardImageFace1;
  String identityCardImageFace2;
  String licenceImageFace1;
  String licenceImageFace2;
  String? moreImage1;
  String? moreImage2;
  String? moreImage3;
  String password;
}