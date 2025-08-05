import 'package:app/ui/provider_catastro.dart';
import 'package:app/ui/provider_registro.dart';
import 'package:app/ui/provider_sesion.dart';
import 'package:app/ui/widgets/base_pantalla.dart';
import 'package:app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizing/sizing.dart';

class PantallaSeleccionarVivienda extends StatefulWidget {
  const PantallaSeleccionarVivienda({super.key});

  static const String route = '/registro/seleccionar-vivienda';

  @override
  State<PantallaSeleccionarVivienda> createState() => _PantallaSeleccionarViviendaState();
}

class _PantallaSeleccionarViviendaState extends State<PantallaSeleccionarVivienda> {
  final MapController _mapController = MapController();
  Position? locationData;
  bool loadingLocation = true;
  @override
  void initState() {
    _determinePosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BasePantalla(
      title: 'PRESIONES', 
      padding: EdgeInsets.zero,
      body:  !loadingLocation ? Column(
        children: [
          _wMapa(context),
          _wViviendas()
        ],
      ) : Center(child: CircularProgressIndicator())
    );
  }

  SizedBox _wMapa(BuildContext context) {
    final pCatastroW = context.watch<ProviderCatastro>();
    return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(locationData!.latitude,locationData!.longitude),
                  initialZoom: 18,
                  minZoom: 0,
                  maxZoom: 100
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.umayakuy.app',
                    //tileProvider: _tileProvider,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(locationData!.latitude!, locationData!.longitude!), 
                        width: 25,
                        height: 25,
                        child: Icon(Icons.location_on_sharp, color: Colors.red,)
                      ),
                      ...pCatastroW.viviendas.map((e) {
                        return Marker(
                          point: LatLng(e.latitud, e.longitud), 
                          width: 15,
                          height: 15,
                          child: Tooltip(
                            message: e.catastro,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(
                                  width: 1,
                                  color: pCatastroW.viviendaSel.id == e.id ? Colors.cyanAccent.shade100 : Colors.transparent
                                ),
                                boxShadow: pCatastroW.viviendaSel.id == e.id ? [
                                  BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.white,
                                    spreadRadius: 5
                                  ) 
                                ]: null,
                                borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                          )
                        );
                      })
                    ]
                  )
                ]
              )
            ],
          ),
        );
  }

  Widget _wViviendas() {
    final pCatastroW = context.watch<ProviderCatastro>();
    return Container(
      decoration: BoxDecoration(
        color: colorPrincipal
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40.ss,
            decoration: BoxDecoration(
              color: Colors.blueAccent
            ),
            child: Center(
              child: Text(
                'SELECCIONAR VIVIENDA', 
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white
                ),
              )
            ),
          ),
          ...pCatastroW.viviendas.map((v) {
            return Material(
              color: Colors.transparent,
              child: ListTile(
                splashColor: colorPrincipal,
                title: Text(
                  v.catastro,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.white
                  ),
                ),
                trailing: pCatastroW.viviendaSel.id == v.id ?  IconButton(
                  onPressed: () {
                    context.read<ProviderRegistro>().setVivienda(v);
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.check_circle, color: colorFondo,)
                ) : SizedBox(),
                onTap: () {
                  context.read<ProviderCatastro>().setViviendaSel(v);
                }, 
              ),
            );
          })
          
        ],
      ),
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 100,
    );
    locationData = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    context.read<ProviderCatastro>().getViviendasCercanas(circuito: context.read<ProviderSesion>().circuito,latitud: locationData!.latitude, longitud: locationData!.longitude);
    setState(() {
      loadingLocation = false;
    });
    return locationData!;
  }
}