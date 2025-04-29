import 'package:bruroam/provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:bruroam/screen/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RideDetailScreen extends StatelessWidget {
  const RideDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy'),
        backgroundColor: const Color(0xFFF2DC56),

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

        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
      color: const Color(0xFFFFCC33),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              
            },
          ),
          const SizedBox(width: 15),
          const Row(
            children: [
              Icon(Icons.directions_car, color: Colors.black),
              SizedBox(width: 8),
              Text(
                'Transport',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocations() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
                    // Header with Transport title
          _buildHeader(),
          
          // Locations section
          _buildLocations(),
          
          // Details header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[200],
            child: const Text(
              'Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Transport details
          _buildTransportDetails(),
          
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text("Map would be displayed here"),
              ),
            ),
          ),
        
          // Origin location
          Row(
            children: [
              _buildLocationMarker(Colors.green),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jalan Tapak Kuda',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bandar Seri Begawan BB3910, Brunei Darussalam',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Destination location
          Row(
            children: [
              _buildLocationMarker(Colors.red),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jalan Sultan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bandar Seri Begawan BS 8711, Brunei Darussalam',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationMarker(Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.location_on, color: Colors.white, size: 20),
    );
  }

  Widget _buildTransportDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.local_taxi, size: 36),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Taxi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '20 mins',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            '\$15.00',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
