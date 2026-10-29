import 'package:flutter/material.dart';

import 'package:examen_movil/base/custom_exception.dart';
import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/carts/carts_service.dart';
import 'package:examen_movil/home/home_screen.dart';
import 'package:examen_movil/login/login_service.dart';
import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/products/products_service.dart';
import 'package:examen_movil/widgets/app_text_field.dart';
import 'package:examen_movil/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  final LoginService loginService;
  final ProductsService productsService;
  final ProductByIdService productByIdService;
  final CartsService cartsService;
  final CartDetailService cartDetailService;

  const LoginScreen({
    super.key,
    required this.loginService,
    required this.productsService,
    required this.productByIdService,
    required this.cartsService,
    required this.cartDetailService,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String message) {
    return value == null || value.trim().isEmpty ? message : null;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await widget.loginService.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );
      if (!mounted) return;
      // Login correcto: reemplaza la pantalla de login por la principal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            productsService: widget.productsService,
            productByIdService: widget.productByIdService,
            cartsService: widget.cartsService,
            cartDetailService: widget.cartDetailService,
          ),
        ),
      );
    } on CustomException catch (e) {
      // DummyJSON responde 400 cuando las credenciales no coinciden.
      if (!mounted) return;
      _showError(
        e.status == 400
            ? 'Usuario o contraseña incorrectos'
            : 'No se pudo iniciar sesión, intenta de nuevo',
      );
    } catch (_) {
      if (mounted) _showError('No se pudo iniciar sesión, intenta de nuevo');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _StoreTitle(),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Usuario',
                  controller: _usernameController,
                  validator: (value) =>
                      _validateRequired(value, 'Ingresa tu usuario'),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Contraseña',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) =>
                      _validateRequired(value, 'Ingresa tu contraseña'),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Aceptar',
                  onPressed: _isLoading ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreTitle extends StatelessWidget {
  const _StoreTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.storefront_outlined,
          size: 32,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Text('TIENDA EXAMEN', style: theme.textTheme.headlineLarge),
      ],
    );
  }
}
