import 'package:get/get.dart';
import 'package:mybidan/presentation/shop/controller/detail_product_controller.dart';

class DetailProductBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailProductController());
  }
}
