import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repo/home_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxBool isLoading = false.obs;

  List<CategoryModel> categories = [];

  List<ItemModel> products = [];

  CategoryModel? currentCategory;

  @override
  void onInit() {
    super.onInit();
    getCategoryList();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    getProductList();
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
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        selectCategory(categories.first);
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }

  Future<void> getProductList() async {
    final body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    isLoading.value = true;
    final result = await _homeRepository.getProductList(body);
    isLoading.value = false;
    result.when(
      success: (data) {
        products.assignAll(data);
        if (data.isEmpty) {
          return;
        }
        print(products);
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
