import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_config.dart';
import '../../../domain/entities/reserve.dart';

class ReservesPage extends StatefulWidget {
  const ReservesPage({super.key});

  @override
  State<ReservesPage> createState() => _ReservesPageState();
}

class _ReservesPageState extends State<ReservesPage> {
  final List<Reserve> _reserves = [
    Reserve(
      reserveId: '1',
      nombre: 'Reserva Natural Indio Maíz',
      descripcion: 'Una de las reservas más grandes de Nicaragua, hogar de cientos de especies de aves y vida silvestre.',
      lat: 10.8231,
      lng: -83.5677,
      provincia: 'Río San Juan',
      horario: '6:00 AM - 6:00 PM',
      telefono: '+505 8888-8888',
      emailContacto: 'info@indio-maiz.com',
    ),
    Reserve(
      reserveId: '2',
      nombre: 'Reserva Natural Cerro Silva',
      descripcion: 'Montaña cubierta de bosque tropical húmedo, perfecta para observación de aves.',
      lat: 11.2345,
      lng: -84.1234,
      provincia: 'Río San Juan',
      horario: '7:00 AM - 5:00 PM',
      telefono: '+505 7777-7777',
      emailContacto: 'contact@cerro-silva.com',
    ),
    Reserve(
      reserveId: '3',
      nombre: 'Reserva Natural Volcán Mombacho',
      descripcion: 'Volcán inactivo con bosque nuboso, famoso por sus orquídeas y aves endémicas.',
      lat: 11.8267,
      lng: -85.9683,
      provincia: 'Granada',
      horario: '8:00 AM - 4:00 PM',
      telefono: '+505 6666-6666',
      emailContacto: 'info@mombacho.com',
    ),
    Reserve(
      reserveId: '4',
      nombre: 'Reserva Natural Chocoyero-El Brujo',
      descripcion: 'Reserva conocida por sus cascadas y la colonia de pericos que habitan en los acantilados.',
      lat: 12.1234,
      lng: -86.2345,
      provincia: 'Managua',
      horario: '6:00 AM - 6:00 PM',
      telefono: '+505 5555-5555',
      emailContacto: 'info@chocoyero.com',
    ),
  ];

  String _searchQuery = '';
  String _selectedProvince = 'Todas';

  List<Reserve> get _filteredReserves {
    return _reserves.where((reserve) {
      final matchesSearch = reserve.nombre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (reserve.descripcion?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      
      final matchesProvince = _selectedProvince == 'Todas' || reserve.provincia == _selectedProvince;
      
      return matchesSearch && matchesProvince;
    }).toList();
  }

  List<String> get _provinces {
    final provinces = _reserves.map((r) => r.provincia ?? '').where((p) => p.isNotEmpty).toSet().toList();
    provinces.sort();
    return ['Todas', ...provinces];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservas Naturales'),
        backgroundColor: const Color(AppConfig.primaryColor),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar reservas...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                const SizedBox(height: 12),
                // Province Filter
                DropdownButtonFormField<String>(
                  value: _selectedProvince,
                  decoration: InputDecoration(
                    labelText: 'Provincia',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  items: _provinces.map((province) {
                    return DropdownMenuItem(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Results Count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${_filteredReserves.length} reservas encontradas',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Reserves List
          Expanded(
            child: _filteredReserves.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredReserves.length,
                    itemBuilder: (context, index) {
                      final reserve = _filteredReserves[index];
                      return _buildReserveCard(reserve);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildReserveCard(Reserve reserve) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.go('/reserves/${reserve.reserveId}'),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.forest,
                      size: 64,
                      color: Colors.green[600],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reserve.estado,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reserve.nombre,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(AppConfig.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reserve.descripcion ?? 'Sin descripción disponible',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  
                  // Info Row
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                                             Text(
                         reserve.provincia ?? 'Sin ubicación',
                         style: TextStyle(
                           color: Colors.grey[600],
                           fontSize: 14,
                         ),
                       ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        reserve.horario ?? 'Horario no disponible',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.go('/reserves/${reserve.reserveId}'),
                          icon: const Icon(Icons.info_outline),
                          label: const Text('Ver Detalles'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(AppConfig.primaryColor),
                            side: const BorderSide(color: Color(AppConfig.primaryColor)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.go('/bookings/create?reserveId=${reserve.reserveId}'),
                          icon: const Icon(Icons.calendar_today),
                          label: const Text('Reservar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppConfig.primaryColor),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron reservas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta ajustar los filtros de búsqueda',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
