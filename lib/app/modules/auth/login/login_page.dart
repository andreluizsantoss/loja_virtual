import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual/app/core/ui/extensions/size_screen_extension.dart';
import 'package:loja_virtual/app/core/ui/extensions/theme_extension.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/helpers/format_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage(
                  'assets/images/logo.jpg',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: _emailEC,
                        decoration: const InputDecoration(
                          hintText: 'E-mail',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        inputFormatters: [
                          LowerCaseText(),
                        ],
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                        focusNode: _focusEmail,
                        onFieldSubmitted: (String text) {
                          FocusScope.of(context).requestFocus(_focusPassword);
                        },
                      ),
                      TextFormField(
                        controller: _passwordEC,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                        ),
                        autocorrect: false,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                          Validatorless.min(
                              8, 'Senha precisa ter pelo menos 8 caracteres'),
                        ]),
                        focusNode: _focusPassword,
                        onFieldSubmitted: (String text) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 44.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.primaryColor,
                            disabledBackgroundColor: Colors.grey.shade500,
                          ),
                          onPressed: () {
                            final formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {}
                          },
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Modular.to.pushNamed('/auth/register/'),
              child: Text(
                'Não possui conta? Cadastre-se',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
