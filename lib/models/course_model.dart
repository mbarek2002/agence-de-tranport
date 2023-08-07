import '../controllers/courses/courses_controller.dart';

class CourseModel {
  String? id;
  String type;
  String pickUpLocation;
  String? dropOffLocation;
  DateTime pickUpDate;
  DateTime? dropOffDate;
  int? passengersNum;
  String driverName;
  String? orderUrl;
  List<rowdata>? passengersDetails;
  int? identityNum;



  CourseModel({this.id,required this.type,required  this.pickUpLocation,  this.dropOffLocation,this.dropOffDate,
    required this.pickUpDate,  this.passengersNum,required this.driverName, this.orderUrl,this.passengersDetails,
  this.identityNum});

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'pickUpLocation': pickUpLocation,
//       if(dropOffLocation!=null) 'dropOffLocation':dropOffLocation,
//       'pickUpDate':pickUpDate,
//       if(dropOffDate!=null) 'dropOffDate':dropOffDate,
//       if(passengersNum!=null) 'passengersNum':passengersNum,
//
//
//     };
//
 }