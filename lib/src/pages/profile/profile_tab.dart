import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/configs/app_data.dart' as mock;
import 'package:greengrocer/src/pages/auth/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/views/components/custom_text_field.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = mock.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => authController.signOut(),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          CustomTextField(
            initialValue: user.name,
            leftIcon: Icons.person_rounded,
            label: 'Nome',
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            initialValue: user.email,
            readOnly: true,
            leftIcon: Icons.email_rounded,
            label: 'E-mail',
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            initialValue: user.phone,
            leftIcon: Icons.phone_android_rounded,
            label: 'Celular',
            inputType: TextInputType.phone,
            inputFormatters: [UtilsServices.phoneFormatter],
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            initialValue: user.cpf,
            readOnly: true,
            leftIcon: Icons.password_rounded,
            label: 'CPF',
            inputType: TextInputType.number,
            inputFormatters: [UtilsServices.cpfFormatter],
            isSecret: true,
          ),
          const SizedBox(height: 32.0),
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
              onPressed: () async {
                bool? result = await updatePassword();

                if (result == true) {
                  //
                } else {
                  //
                }
              },
              child: Text(
                'Atualizar senha',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return Center(
            child: SingleChildScrollView(
              child: Dialog(
                elevation: 5,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Atualizar senha',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16.0),
                          const CustomTextField(
                            label: 'Senha atual',
                            isSecret: true,
                            leftIcon: Icons.lock_rounded,
                          ),
                          const SizedBox(height: 8.0),
                          const CustomTextField(
                            label: 'Nova senha',
                            isSecret: true,
                            leftIcon: Icons.lock_outline_rounded,
                          ),
                          const SizedBox(height: 8.0),
                          const CustomTextField(
                            label: 'Confirmar senha',
                            isSecret: true,
                            leftIcon: Icons.lock_outline_rounded,
                          ),
                          const SizedBox(height: 32.0),
                          SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Alterar',
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
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
