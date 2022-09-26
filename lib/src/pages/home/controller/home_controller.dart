import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repo/home_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();

  RxString searchTitle = ''.obs;

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

    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );

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

  void filterByTitle() {
    // apagar todos os produtos das categorias.
    for (var cat in categories) {
      cat.items.clear();
      cat.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      categories.removeAt(0);
    } else {
      final categoryExists =
          categories.firstWhereOrNull((element) => element.id == '');

      if (categoryExists == null) {
        final allCategory = CategoryModel(
          id: '',
          title: 'Todos',
          items: [],
          pagination: 0,
        );

        categories.insert(0, allCategory);
      } else {
        // Todos já existe, então limpa os itens da pesquisa.
        categoryExists.items.clear();
        categoryExists.pagination = 0;
      }
    }

    // Define a categoria atual como a primera 'Todos'.
    currentCategory = categories.first;

    update();

    getProductList();
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
    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        // se a categoria atual for a 'Todos', remove a filtragem por categoria da requisição.
        body.remove('categoryId');
      }
    }
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
