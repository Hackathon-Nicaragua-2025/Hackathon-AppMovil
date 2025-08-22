import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simular proceso de login
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        // TODO: Implementar lógica de autenticación real
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Funcionalidad de login en desarrollo'),
            backgroundColor: Colors.orange,
          ),
        );
      });
    }
  }

  void _handleGoogleLogin() {
    setState(() {
      _isLoading = true;
    });

    // Simular login con Google
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      // TODO: Implementar login con Google
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login con Google en desarrollo'),
          backgroundColor: Colors.orange,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo y título
                _buildHeader(),
                const SizedBox(height: 48),
                
                // Formulario de login
                _buildLoginForm(),
                const SizedBox(height: 24),
                
                // Botón de login
                _buildLoginButton(),
                const SizedBox(height: 16),
                
                // Divider
                _buildDivider(),
                const SizedBox(height: 16),
                
                // Botón de Google
                _buildGoogleButton(),
                const SizedBox(height: 32),
                
                // Enlaces adicionales
                _buildAdditionalLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo placeholder
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(AppConfig.primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.flutter_dash,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '¡Bienvenido de vuelta!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(AppConfig.primaryColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Inicia sesión para continuar',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        // Campo de email
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Correo electrónico',
            hintText: 'ejemplo@correo.com',
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu correo electrónico';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Por favor ingresa un correo electrónico válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        // Campo de contraseña
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            hintText: 'Ingresa tu contraseña',
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu contraseña';
            }
            if (value.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        
        // Recordar contraseña y olvidé contraseña
        Row(
          children: [
            // Checkbox recordar
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                  activeColor: const Color(AppConfig.primaryColor),
                ),
                const Text('Recordarme'),
              ],
            ),
            const Spacer(),
            // Enlace olvidé contraseña
            TextButton(
              onPressed: () => context.go('/forgot-password'),
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: Color(AppConfig.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(AppConfig.primaryColor),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o continúa con',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: _isLoading ? null : _handleGoogleLogin,
        icon: Image.network(
          'https://developers.google.com/identity/images/g-logo.png',
          height: 20,
          width: 20,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.g_mobiledata, size: 20);
          },
        ),
        label: const Text(
          'Continuar con Google',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.grey[800],
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalLinks() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿No tienes una cuenta? ',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text(
                'Regístrate aquí',
                style: TextStyle(
                  color: Color(AppConfig.primaryColor),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.go('/'),
          child: Text(
            'Continuar como invitado',
            style: TextStyle(
              color: Colors.grey[600],
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
