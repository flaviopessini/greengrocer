import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/components/custom_text_field.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/services/validators.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppNameWidget(
                        greenTitleColor: Colors.white,
                        textSize: 40.0,
                      ),
                      SizedBox(
                        height: 40.0,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 24.0,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: Duration.zero,
                            animatedTexts: [
                              FadeAnimatedText('Frutas'),
                              FadeAnimatedText('Cafés'),
                              FadeAnimatedText('Cereais'),
                              FadeAnimatedText('Embutidos'),
                              FadeAnimatedText('Laticínios'),
                              FadeAnimatedText('Legumes'),
                              FadeAnimatedText('Temperos'),
                              FadeAnimatedText('Verduras'),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                          controller: emailController,
                          leftIcon: Icons.email_rounded,
                          label: 'E-mail',
                          inputType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 8.0),
                        CustomTextField(
                          controller: passwordController,
                          leftIcon: Icons.lock_rounded,
                          label: 'Senha',
                          isSecret: true,
                          validator: passwordValidator,
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                          height: 48.0,
                          child: GetX<AuthController>(
                            builder: (ctrl) => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                              onPressed: ctrl.isLoading.isFalse
                                  ? () {
                                      FocusScope.of(context).unfocus();

                                      if (_formKey.currentState!.validate()) {
                                        String email =
                                            emailController.text.trim();
                                        String password =
                                            passwordController.text.trim();

                                        ctrl.signIn(
                                            email: email, password: password);

                                        // Get.offNamed(PagesRoutes.baseRoute);
                                      }
                                    }
                                  : null,
                              child: ctrl.isLoading.isFalse
                                  ? Text(
                                      'Entrar',
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
                        const SizedBox(height: 4.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text('ou'),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              side: BorderSide(
                                width: 1.5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(PagesRoutes.signUpRoute);
                            },
                            child: Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .fontSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
