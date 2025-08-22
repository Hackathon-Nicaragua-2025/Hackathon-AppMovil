import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConfig.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(AppConfig.primaryColor),
                    Color(AppConfig.secondaryColor),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.flutter_dash,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '¡Bienvenido a AveTurismo!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Descubre las maravillas naturales de Nicaragua',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Main Features Grid
            Text(
              'Explorar',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildFeatureCard(
                  context,
                  'Reservas Naturales',
                  Icons.forest,
                  Colors.green,
                  () => context.go('/reserves'),
                ),
                _buildFeatureCard(
                  context,
                  'Catálogo de Aves',
                  Icons.flutter_dash,
                  Colors.blue,
                  () => context.go('/birds'),
                ),
                _buildFeatureCard(
                  context,
                  'Mis Reservas',
                  Icons.calendar_today,
                  Colors.orange,
                  () => context.go('/bookings'),
                ),
                _buildFeatureCard(
                  context,
                  'Eventos',
                  Icons.event,
                  Colors.purple,
                  () => context.go('/events'),
                ),
                _buildFeatureCard(
                  context,
                  'Educación',
                  Icons.school,
                  Colors.teal,
                  () => context.go('/education'),
                ),
                _buildFeatureCard(
                  context,
                  'Nueva Reserva',
                  Icons.add_circle,
                  Colors.red,
                  () => context.go('/bookings/create'),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Quick Stats Section
            Text(
              'Estadísticas Rápidas',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Reservas',
                    '15',
                    Icons.forest,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Aves',
                    '250+',
                    Icons.flutter_dash,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Eventos',
                    '8',
                    Icons.event,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Authentication Section
            Text(
              'Acceso a la Aplicación',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.go('/login'),
                    icon: const Icon(Icons.login),
                    label: const Text('Iniciar Sesión'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppConfig.primaryColor),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/register'),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Registrarse'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(AppConfig.primaryColor),
                      side: const BorderSide(color: Color(AppConfig.primaryColor)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
