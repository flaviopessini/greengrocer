import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repo/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  final authRepository = AuthRepository();

  RxBool isLoading = false.obs;

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  void saveTokenAndGoToBase() async {
    await UtilsServices.saveLocalData(key: StorageKeys.token, value: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signOut() async {
    user = UserModel();
    await UtilsServices.removeLocalData(StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> validateToken() async {
    final token = await UtilsServices.getLocalData(StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }
    final result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndGoToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    final AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndGoToBase();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signUp() async {
    isLoading.value = true;
    final AuthResult result = await authRepository.signUp(user);
    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndGoToBase();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
