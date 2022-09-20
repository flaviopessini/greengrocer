import 'package:get/get.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repo/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();

  RxBool isLoading = false.obs;

  UserModel user = UserModel();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    final AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
