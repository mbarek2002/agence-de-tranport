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
  List<checklistData>? carListDetails;
  String? carImage1URL;
  String? carImage2URL;
  String? carImage3URL;
  String? carImage4URL;

  int? luggageBigSize;
  int? usedLuggageBigSize;

  int? luggageMediumSize;
  int? usedLuggageMediumSize;

  int? collie;
  int? usedCollie;

  int identityNum;
  bool? seen;
  bool? finished;
  String check;




      Course({this.id,this.finished,this.adminId,required  this.pickUpLocation,required this.dropOffLocation,this.dropOffDate,
    required this.pickUpDate, required this.passengersNum, required this.seatingCapacity, required this.regNumber
    ,required this.driverName, this.orderUrl,this.passengersDetails,this.carListDetails,this.carImage1URL,
        this.carImage2URL,this.carImage3URL,this.carImage4URL, this.seen, this.luggageBigSize, this.luggageMediumSize,
        this.usedLuggageBigSize,this.usedLuggageMediumSize,this.collie,this.usedCollie,required this.check,
    required this.identityNum});


}