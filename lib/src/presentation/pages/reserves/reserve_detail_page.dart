import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_config.dart';
import '../../../domain/entities/reserve.dart';

class ReserveDetailPage extends StatefulWidget {
  final String reserveId;

  const ReserveDetailPage({super.key, required this.reserveId});

  @override
  State<ReserveDetailPage> createState() => _ReserveDetailPageState();
}

class _ReserveDetailPageState extends State<ReserveDetailPage> {
  late Reserve _reserve;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReserveData();
  }

  void _loadReserveData() {
    // Simular carga de datos
    Future.delayed(const Duration(milliseconds: 500), () {
      _reserve = _getReserveById(widget.reserveId);
      setState(() {
        _isLoading = false;
      });
    });
  }

  Reserve _getReserveById(String id) {
    final reserves = [
      Reserve(
        reserveId: '1',
        nombre: 'Reserva Natural Indio Maíz',
        descripcion: 'La Reserva Natural Indio Maíz es una de las reservas más grandes y biodiversas de Nicaragua. Con una extensión de más de 2,600 km², esta reserva alberga una increíble variedad de vida silvestre, incluyendo más de 400 especies de aves, jaguares, tapires, monos y una gran diversidad de flora tropical.',
        lat: 10.8231,
        lng: -83.5677,
        direccion: 'Carretera San Carlos - El Castillo, Río San Juan',
        provincia: 'Río San Juan',
        horario: '6:00 AM - 6:00 PM',
        telefono: '+505 8888-8888',
        emailContacto: 'info@indio-maiz.com',
      ),
      Reserve(
        reserveId: '2',
        nombre: 'Reserva Natural Cerro Silva',
        descripcion: 'El Cerro Silva es una imponente montaña cubierta de bosque tropical húmedo que se eleva majestuosamente en el sureste de Nicaragua. Esta reserva es un paraíso para los observadores de aves, con más de 300 especies registradas, incluyendo el quetzal resplandeciente y el tucán pico iris.',
        lat: 11.2345,
        lng: -84.1234,
        direccion: 'Comunidad El Castillo, Río San Juan',
        provincia: 'Río San Juan',
        horario: '7:00 AM - 5:00 PM',
        telefono: '+505 7777-7777',
        emailContacto: 'contact@cerro-silva.com',
      ),
      Reserve(
        reserveId: '3',
        nombre: 'Reserva Natural Volcán Mombacho',
        descripcion: 'El Volcán Mombacho es un volcán inactivo que alberga un bosque nuboso único en Nicaragua. Con senderos bien mantenidos y miradores espectaculares, esta reserva es famosa por sus orquídeas, bromelias y aves endémicas como el colibrí esmeralda.',
        lat: 11.8267,
        lng: -85.9683,
        direccion: 'Carretera Granada - Nandaime, Granada',
        provincia: 'Granada',
        horario: '8:00 AM - 4:00 PM',
        telefono: '+505 6666-6666',
        emailContacto: 'info@mombacho.com',
      ),
      Reserve(
        reserveId: '4',
        nombre: 'Reserva Natural Chocoyero-El Brujo',
        descripcion: 'Esta reserva es conocida por sus impresionantes cascadas y la colonia de pericos que habitan en los acantilados. Con senderos que conducen a miradores naturales, los visitantes pueden observar estas aves coloridas en su hábitat natural.',
        lat: 12.1234,
        lng: -86.2345,
        direccion: 'Carretera Managua - León, Ticuantepe',
        provincia: 'Managua',
        horario: '6:00 AM - 6:00 PM',
        telefono: '+505 5555-5555',
        emailContacto: 'info@chocoyero.com',
      ),
    ];

    return reserves.firstWhere(
      (reserve) => reserve.reserveId == id,
      orElse: () => Reserve(
        reserveId: '0',
        nombre: 'Reserva no encontrada',
        descripcion: 'La reserva solicitada no existe o no está disponible.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cargando...'),
          backgroundColor: const Color(AppConfig.primaryColor),
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar con imagen
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(AppConfig.primaryColor),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _reserve.nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.green[400]!,
                      Colors.green[700]!,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.forest,
                        size: 120,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _reserve.estado,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Descripción
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(AppConfig.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _reserve.descripcion ?? 'Sin descripción disponible',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Información de contacto
                  _buildInfoSection(
                    'Información de Contacto',
                    Icons.contact_phone,
                    [
                      if (_reserve.telefono != null)
                        _buildInfoRow(Icons.phone, 'Teléfono', _reserve.telefono!),
                      if (_reserve.emailContacto != null)
                        _buildInfoRow(Icons.email, 'Email', _reserve.emailContacto!),
                      if (_reserve.horario != null)
                        _buildInfoRow(Icons.access_time, 'Horario', _reserve.horario!),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Ubicación
                  _buildInfoSection(
                    'Ubicación',
                    Icons.location_on,
                    [
                      if (_reserve.provincia != null)
                        _buildInfoRow(Icons.map, 'Provincia', _reserve.provincia!),
                      if (_reserve.direccion != null)
                        _buildInfoRow(Icons.place, 'Dirección', _reserve.direccion!),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Mapa placeholder
                  _buildMapSection(),
                  const SizedBox(height: 24),

                  // Servicios disponibles
                  _buildServicesSection(),
                  const SizedBox(height: 32),

                  // Botones de acción
                  _buildActionButtons(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(AppConfig.primaryColor),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(AppConfig.primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.map,
              color: const Color(AppConfig.primaryColor),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Ubicación en el Mapa',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(AppConfig.primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mapa de ubicación',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_reserve.lat?.toStringAsFixed(4)}, ${_reserve.lng?.toStringAsFixed(4)}',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Abrir mapa externo
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Funcionalidad de mapa en desarrollo'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Abrir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(AppConfig.primaryColor),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.list_alt,
              color: const Color(AppConfig.primaryColor),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Servicios Disponibles',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(AppConfig.primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildServiceChip('Observación de Aves', Icons.flutter_dash),
            _buildServiceChip('Senderismo', Icons.directions_walk),
            _buildServiceChip('Fotografía', Icons.camera_alt),
            _buildServiceChip('Guías Locales', Icons.person),
            _buildServiceChip('Estacionamiento', Icons.local_parking),
            _buildServiceChip('Baños', Icons.wc),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16, color: const Color(AppConfig.primaryColor)),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.green[50],
      side: BorderSide(color: Colors.green[200]!),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => context.go('/bookings/create?reserveId=${_reserve.reserveId}'),
            icon: const Icon(Icons.calendar_today),
            label: const Text(
              'Reservar Visita',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConfig.primaryColor),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Compartir reserva
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidad de compartir en desarrollo'),
                    ),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Compartir'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(AppConfig.primaryColor),
                  side: const BorderSide(color: Color(AppConfig.primaryColor)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Agregar a favoritos
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidad de favoritos en desarrollo'),
                    ),
                  );
                },
                icon: const Icon(Icons.favorite_border),
                label: const Text('Favorito'),
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
    );
  }
}
