import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Location/location_provider.dart';

class GoogleMapSection extends StatelessWidget {
  const GoogleMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
        builder: (context,provider,_){
          return GestureDetector(
            child: RepaintBoundary(
              child: GoogleMap(
                  initialCameraPosition: provider.kGooglePlex,
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId("1"),
                      position: LatLng(
                          provider.kGooglePlex.target.latitude,
                          provider.kGooglePlex.target.longitude),
                    ),
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller){
                    if (!provider.gController.isCompleted) {
                      provider.gController.complete(controller);
                    }
                    },
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                    ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                    ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                    ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()))
              ),
            ),
          );
        });
  }
}
