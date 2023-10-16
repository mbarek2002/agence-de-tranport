
import 'package:image_picker/image_picker.dart';

class DriverModel {
  final String? id;
  final String driverImage;
  final String firstName;
  final String lastName;
  final String birthDate;
  final int identityNumber;
  final String identityCardImageFace1;
  final String identityCardImageFace2;
  final int phoneNumber;
  final String licenceType;
  final String licenceImageFace1;
  final String licenceImageFace2;
  final String email;
  final String contractType;
  final String password;
   String? moreImage1;
   String? moreImage2;
   String? moreImage3;
   String? nbCourses="";

  DriverModel({
     this.id,
   required  this.driverImage,
    required this.firstName,
    required this.lastName,
  required this.birthDate,
  required this.identityNumber,
  required this.identityCardImageFace1,
  required this.identityCardImageFace2,
  required this.phoneNumber,
  required this.licenceType,
  required this.licenceImageFace1,
  required this.licenceImageFace2,
  required this.email,
  required this.contractType,
    required this.password,
     this.moreImage1,
     this.moreImage2,
     this.moreImage3,
    this.nbCourses

  });
}