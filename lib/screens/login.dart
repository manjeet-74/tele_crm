import 'package:flutter/material.dart';
import 'package:tele_crm/screens/dashboard.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600)); // mock
    setState(() => _loading = false);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, DashboardScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    const panelBlue = Color(0xFFD9F1FF); // light blue panel
    const pageBg = Colors.white;

    return Scaffold(
      backgroundColor: pageBg,
      body: LayoutBuilder(
        builder: (context, c) {
          final isWide = c.maxWidth >= 600;

          final content = Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 24 : 16,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Log In',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // Light blue rounded panel with fields + link
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      decoration: BoxDecoration(
                        color: panelBlue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email field
                            _PillTextField(
                              controller: _email,
                              hintText: "Email I'd",
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) => (v == null || !v.contains('@'))
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            // Password field
                            _PillTextField(
                              controller: _password,
                              hintText: 'Password',
                              obscureText: _obscure,
                              suffix: IconButton(
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              validator: (v) => (v == null || v.length < 6)
                                  ? 'Minimum 6 characters'
                                  : null,
                            ),
                            const SizedBox(height: 18),

                            // Forgot password centered under fields
                            TextButton(
                              onPressed: _loading ? null : () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black87,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              child: const Text('Forgot password'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Rounded blue "Log in" button
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: panelBlue,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _loading ? null : _submit,
                        child: _loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text(
                                'Log in',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Underlined Sign Up
                    TextButton(
                      onPressed: _loading ? null : () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black87,
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Rounded “pill” text field used inside the blue panel
class _PillTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const _PillTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.45), // more faded placeholder
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black54),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        suffixIcon: suffix,
      ),
      style: const TextStyle(fontSize: 14),
    );
  }
}
