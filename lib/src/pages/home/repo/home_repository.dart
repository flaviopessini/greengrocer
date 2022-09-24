import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getCategoryList() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCategoryList,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      final data = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao listar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getProductList(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getProductList,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] != null) {
      final data = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => ItemModel.fromJson(e))
          .toList();
      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro ao carregar a lista de produtos');
    }
  }
}
