import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bruroam/provider/locale_provider.dart';


class TransportSelectionPage extends StatefulWidget {
  const TransportSelectionPage({super.key});

  @override
  State<TransportSelectionPage> createState() => _TransportSelectionPageState();
}

class _TransportSelectionPageState extends State<TransportSelectionPage> {
  final MapController _mapController = MapController();
  LatLng _startLocation = LatLng(4.89, 114.942); // default
  LatLng _destination = LatLng(4.89, 114.942);   // will be updated if needed
  String? _selectedTransportType;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _startLocation = LatLng(position.latitude, position.longitude);
      _destination = _startLocation; // for now, destination is same
    });
    _mapController.move(_startLocation, 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport'),
        backgroundColor: const Color(0xFFF2DC56),
        centerTitle: true,

        actions: [
          DropdownButton<Locale>(
            items: AppLocalizations.supportedLocales.map(
              (locale) => DropdownMenuItem<Locale> (
                value: locale,
                child: Text(locale.languageCode),
              ),
            ).toList(),
            onChanged: (Locale? locale) {
              if(locale != null) {
                provider.setLocale(locale);
              }
            }
          ),
        ],
    ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.5,
                                child: FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    initialCenter: _startLocation,
                                    initialZoom: 16.0,
                                    interactionOptions: const InteractionOptions(
                                      flags: InteractiveFlag.none,
                                    ),
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      tileProvider: CancellableNetworkTileProvider(),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 16),
                                        child: Text(
                                          'choose your transport',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(height: 1, color: Colors.grey[300]),
                                      _transportOption(
                                        type: 'Taxi',
                                        price: 15.00,
                                        duration: '20 mins',
                                      ),
                                      Container(height: 1, color: Colors.grey[300]),
                                      _transportOption(
                                        type: 'Bus',
                                        price: 2.00,
                                        duration: '35 mins',
                                      ),
                                      Container(height: 1, color: Colors.grey[300]),
                                      Container(
                                        height: 50,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text(
                                                  'Back',
                                                  style: TextStyle(color: Colors.black87),
                                                ),
                                              ),
                                            ),
                                            Container(width: 1, color: Colors.grey[300]),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: _selectedTransportType != null
                                                    ? () {
                                                      Navigator.pushNamed(context, '/next');
                                                      }
                                                    : null,
                                                child: Text(
                                                  'Next',
                                                  style: TextStyle(
                                                    color: _selectedTransportType != null
                                                        ? Colors.amber[700]
                                                        : Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          color: const Color(0xFFFFC107).withOpacity(0.5),
                          child: const Center(
                            child: Text('Save Location'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transportOption({
    required String type,
    required double price,
    required String duration,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTransportType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: _selectedTransportType == type ? Colors.grey[100] : null,
        child: Row(
          children: [
            Icon(type == 'Taxi' ? Icons.local_taxi : Icons.directions_bus, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$type  \$$price',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${type == 'Taxi' ? 'Best route' : 'Cheaper'}, $duration',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
