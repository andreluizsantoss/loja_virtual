import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loja_virtual/app/core/ui/extensions/size_screen_extension.dart';
import 'package:loja_virtual/app/core/ui/extensions/theme_extension.dart';
import 'package:loja_virtual/app/modules/auth/register/register_store.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/helpers/format_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _passwordConfirmEC = TextEditingController();
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusConfirmPassword = FocusNode();
  final controller = Modular.get<RegisterStore>();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _passwordConfirmEC.dispose();
    _focusName.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    _focusConfirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRIAR CONTA',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
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
                        controller: _nameEC,
                        decoration: const InputDecoration(
                          hintText: 'Nome Completo',
                        ),
                        autocorrect: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Nome Completo obrigatório'),
                          (name) {
                            if (name!.trim().split(' ').length <= 1) {
                              return 'Preencha seu Nome Completo';
                            }
                            return null;
                          }
                        ]),
                        focusNode: _focusName,
                        onFieldSubmitted: (String text) {
                          FocusScope.of(context).requestFocus(_focusEmail);
                        },
                      ),
                      const SizedBox(
                        height: 6,
                      ),
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
                      const SizedBox(
                        height: 6,
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
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        controller: _passwordConfirmEC,
                        decoration: const InputDecoration(
                          hintText: 'Repita a Senha',
                        ),
                        autocorrect: false,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Repita a Senha obrigatória'),
                          Validatorless.min(
                              8, 'Senha precisa ter pelo menos 8 caracteres'),
                          Validatorless.compare(
                              _passwordEC, 'Senha não confere'),
                        ]),
                        focusNode: _focusConfirmPassword,
                        onFieldSubmitted: (String text) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
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
                            if (formValid) {
                              controller.register(
                                _nameEC.text,
                                _emailEC.text,
                                _passwordEC.text,
                              );
                            }
                          },
                          child: Text(
                            'Criar Conta',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
