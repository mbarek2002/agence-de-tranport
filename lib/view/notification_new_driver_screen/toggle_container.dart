import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/models/notification_new_driver_model.dart';
import 'package:admin_citygo/view/notification_new_driver_screen/consult_notification_new_driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());

class ToggleContainer extends StatefulWidget {
  ToggleContainer({required this.record});
  DocumentSnapshot record;
  @override
  _ToggleContainerState createState() => _ToggleContainerState();
}

class _ToggleContainerState extends State<ToggleContainer> {
  double _containerSize = 100.0;
  bool _isExpanded = false;
  Color color=Colors.white.withOpacity(0.7);
  double s=0;
  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      _containerSize = _isExpanded ? 170.0 : 100.0;
      color = _isExpanded ? Colors.white : Colors.white.withOpacity(0.4);
      s = _isExpanded ? 1: 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSize,
      child: Container(
        width: _containerSize,
        height: _containerSize,
        color: color,
        child: Padding(
          padding: const EdgeInsets.only(left:18.0),
          child: !_isExpanded ?
                NotExpandedContainer(record: widget.record,):
                 ExpandedContainer(record: widget.record)
        ),

      ),
    );
  }
}

class ExpandedContainer extends StatelessWidget {
   ExpandedContainer({
    super.key,
     required this.record
  });
   DocumentSnapshot record;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width:20, ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                // image: DecorationImage(
                //   image: NetworkImage(record['driverImage']),
                //   fit: BoxFit.cover
                // )
              ),
              child: Stack(
                children: [
                  Center(child: const CircularProgressIndicator(),),
                  Center(child: ClipOval(child: Image(image: NetworkImage(record['driverImage']),width:50,height:50,fit: BoxFit.cover)))
                ],
              ),
            ),
            SizedBox(width: 20,),
            Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(record["firstName"]+ " " + record["lastName"]),
              Text("ID N° :"+record["identityNumber"].toString()),
            ],)
          ],
        ),
        SizedBox(height: 15,) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10)
              ),
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.height*0.05,

              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                  ),
                child: Text(
                  'Consult',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                      color: Colors.white
                  ),
                ) ,
                   onPressed: (){
                    Get.to(()=>ConsultNotiNewDrivers(
                        record:NotificationNewDriver(
                      id: record.id,
                      firstName: record['firstName'],
                      lastName: record['lastName'],
                      birthDate: record['birthDate'],
                      identityNumber: record['identityNumber'],
                      phoneNumber: int.tryParse(record['phoneNumber']) ?? 0,
                      licenceType: record['licenceType'],
                      email: record['email'],
                      valid: record['valid'],
                      driverImage: record['driverImage'],
                      identityCardImageFace1:record['identityCardImageFace1'],
                      identityCardImageFace2:record['identityCardImageFace2'],
                      licenceImageFace1: record['licenceImageFace1'],
                      licenceImageFace2: record['licenceImageFace2'],
                      moreImage1: record['more1'],
                      moreImage2: record['more2'],
                      moreImage3: record['more3'],
                      password:record['password']
                    )));
                   },
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)
              ),
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.height*0.05,

              child: GestureDetector(
                child: Text(
                  'Delete',
                  style: TextStyle(
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                   onTap: (){
                     notificationNewDriverController.delete(record.id);
                   },
              ),
            ),
          ],
        ) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 60,),
            Text(notificationNewDriverController.formatFirebaseTimestamp(record["submissionDate"]),style: TextStyle(fontSize: 10),),
          ],
        )
      ],
    );
  }
}

class NotExpandedContainer extends StatelessWidget {
   NotExpandedContainer({
    super.key,
     required this.record
  }) ;

   DocumentSnapshot record;

  @override
  Widget build(BuildContext context) {
    return
      Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            children:[
            Container(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: NetworkImage(record['driverImage']),
                //     // image:AssetImage("assets/images/home_screen/person.jpg"),
                //     fit: BoxFit.cover
                // ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Center(child: const CircularProgressIndicator(),),
                  Center(child: ClipOval(child: Image(image: NetworkImage(record['driverImage']),width:50,height:50,fit: BoxFit.cover)))
                ],
              ),
            ),

        SizedBox(width: 30,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    record['firstName']+ " "
                        + record["lastName"]
                ),
                Text('ID N°  :'+record['identityNumber'].toString()),
                Text(notificationNewDriverController.formatFirebaseTimestamp(record["submissionDate"]),style: TextStyle(fontSize: 10),)
              ],
            )
        ]),
      ],
    );
  }
}