import '../controllers/courses/courses_controller.dart';

class Course {
  String? id;
  String? adminId;
  String pickUpLocation;
  String dropOffLocation;
  DateTime pickUpDate;
  DateTime? dropOffDate;
  int passengersNum;
  int seatingCapacity;
  String regNumber;
  String driverName;
  String? orderUrl;
  List<rowdata>? passengersDetails;
  int? identityNum;
  bool? seen;
  String check;




      Course({this.id,this.adminId,required  this.pickUpLocation,required this.dropOffLocation,this.dropOffDate,
    required this.pickUpDate, required this.passengersNum, required this.seatingCapacity, required this.regNumber
    ,required this.driverName, this.orderUrl,this.passengersDetails, this.seen,required this.check,
    this.identityNum});


}