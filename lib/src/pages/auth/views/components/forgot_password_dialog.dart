import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/cart/components/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final String email;
  final emailController = TextEditingController();
  final formFieldKey = GlobalKey<FormFieldState>();

  ForgotPasswordDialog({
    Key? key,
    required this.email,
  }) : super(key: key) {
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Recuperação de senha',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text('Digite seu e-mail para recuperar sua senha'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CustomTextField(
                        formKey: formFieldKey,
                        controller: emailController,
                        leftIcon: Icons.email_rounded,
                        label: 'E-mail',
                        inputType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          if(formFieldKey.currentState!.validate()){
                            //
                          }
                        },
                        icon: const Icon(Icons.send_rounded),
                        label: const Text('Enviar'),
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            side: const BorderSide(
                              width: 2.0,
                              color: Colors.green,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
