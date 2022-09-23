import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/components/custom_text_field.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/services/validators.dart';

class SignUpScreen extends StatelessWidget {
  // final cpfFormatter = MaskTextInputFormatter(
  //   mask: '###.###.###-##',
  //   filter: {'#': RegExp(r'[0-9]')},
  // );
  //
  // final phoneFormatter = MaskTextInputFormatter(
  //   mask: '(##) # ####-####',
  //   filter: {'#': RegExp(r'[0-9]')},
  // );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 40.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(48.0),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            label: 'Nome',
                            leftIcon: Icons.person_rounded,
                            validator: nameValidator,
                            onSaved: (value) =>
                                authController.user.name = value,
                          ),
                          const SizedBox(height: 8.0),
                          CustomTextField(
                            label: 'CPF',
                            leftIcon: Icons.password_rounded,
                            inputFormatters: [UtilsServices.cpfFormatter],
                            inputType: TextInputType.number,
                            validator: cpfValidator,
                            onSaved: (value) => authController.user.cpf = value,
                          ),
                          const SizedBox(height: 8.0),
                          CustomTextField(
                            label: 'Celular',
                            leftIcon: Icons.phone_android_rounded,
                            inputFormatters: [UtilsServices.phoneFormatter],
                            inputType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (value) =>
                                authController.user.phone = value,
                          ),
                          const SizedBox(height: 8.0),
                          CustomTextField(
                            label: 'E-mail',
                            leftIcon: Icons.email_rounded,
                            inputType: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (value) =>
                                authController.user.email = value,
                          ),
                          const SizedBox(height: 8.0),
                          CustomTextField(
                            label: 'Senha',
                            leftIcon: Icons.lock_rounded,
                            isSecret: true,
                            validator: passwordValidator,
                            onSaved: (value) =>
                                authController.user.password = value,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 48.0,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                ),
                                onPressed: authController.isLoading.isFalse
                                    ? () {
                                        FocusScope.of(context).unfocus();

                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.signUp();
                                        }
                                      }
                                    : null,
                                child: authController.isLoading.isFalse
                                    ? Text(
                                        'Cadastrar',
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                        ),
                                      )
                                    : const CircularProgressIndicator(
                                        color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      //Navigator.of(context).pop();
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
