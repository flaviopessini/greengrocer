import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repo/home_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  bool isCategoryLoading = false;

  bool isProductLoading = false;

  List<CategoryModel> categories = [];

  CategoryModel? currentCategory;

  List<ItemModel> get products => currentCategory?.items ?? [];

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) {
      return true;
    }
    return currentCategory!.pagination * itemsPerPage > products.length;
  }

  @override
  void onInit() {
    super.onInit();

    // Inicia com efeito loading para os produtos enquanto as categorias são carregadas.
    setProductLoading(true);

    getCategoryList();
  }

  void setCategoryLoading(bool loading) {
    isCategoryLoading = loading;
    update();
  }

  void setProductLoading(bool loading) {
    isProductLoading = loading;
    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) {
      return;
    }

    getProductList();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getProductList(loadingEffect: false);
  }

  Future<void> getCategoryList() async {
    setCategoryLoading(true);
    final result = await _homeRepository.getCategoryList();
    setCategoryLoading(false);
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

  Future<void> getProductList({bool loadingEffect = true}) async {
    if (loadingEffect) {
      setProductLoading(true);
    }
    final body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    final result = await _homeRepository.getProductList(body);
    setProductLoading(false);
    result.when(
      success: (data) {
        if (data.isEmpty) {
          return;
        }
        currentCategory!.items.addAll(data);
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
