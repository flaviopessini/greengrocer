import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/pages/home/repo/home_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxBool isLoading = false.obs;

  List<CategoryModel> categories = [];

  CategoryModel? currentCategory;

  @override
  void onInit() {
    super.onInit();
    getCategoryList();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
  }

  Future<void> getCategoryList() async {
    isLoading.value = true;
    final result = await _homeRepository.getCategoryList();
    isLoading.value = false;
    result.when(
      success: (data) {
        categories.assignAll(data);
        if (categories.isEmpty) {
          return;
        }
        categories.sort(
          (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()),
        );
        selectCategory(categories.first);
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
