
class rowdata {
  final String firstname;
  final String lastName;
  final String phoneNum;
  bool state;
  final int collieNumber;
  final int passengersNumber;

  rowdata(
      {required this.firstname,
        required this.lastName,
        required this.phoneNum,
        required this.state,
        required this.collieNumber,
        required this.passengersNumber
      });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastName': lastName,
      'phoneNum': phoneNum,
      "state": state,
      "collieNumber":collieNumber,
      "passengersNumber":passengersNumber
    };
  }
}