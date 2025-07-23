import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';

class PantallaSeleccionarVivienda extends StatefulWidget {
  const PantallaSeleccionarVivienda({super.key});

  static const String route = '/registro/seleccionar-vivienda';

  @override
  State<PantallaSeleccionarVivienda> createState() => _PantallaSeleccionarViviendaState();
}

class _PantallaSeleccionarViviendaState extends State<PantallaSeleccionarVivienda> {
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      title: 'PRESIONES', 
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(0,0),
              initialZoom: 2,
              minZoom: 0,
              maxZoom: 100
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.umayakuy.app',
                tileProvider: _tileProvider,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(0, 0), 
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100)
                      ),
                    )
                  ),
                  Marker(
                    point: LatLng(	0.000145, 0), 
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(100)
                      ),
                    )
                  )
                ]
              )
            ]
          )
        ],
      )
    );
  }

  final _tileProvider = FMTCTileProvider(
    stores: const {
      'store 2': BrowseStoreStrategy.read,
    },
    urlTransformer: (url) => FMTCTileProvider.urlTransformerOmitKeyValues(
      url: url,
      keys: ['access_key'],
    ),
  );
}