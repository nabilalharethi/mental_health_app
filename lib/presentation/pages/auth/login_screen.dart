import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/buttons.dart';
import '../../providers/auth_provider.dart';
import '../../../core/constants/route_constants.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to MindWell',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Feather.mail),
                    border: OutlineInputBorder(),
                  ),
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Feather.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: Validators.validatePassword,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            authProvider.login(
                              _emailController.text,
                              _passwordController.text,
                               context,
                            );
                          }
                        },
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteConstants.register);
                  },
                  child: const Text('Create an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
