import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<NotificationNewDriverController>(NotificationNewDriverController());
  }

}