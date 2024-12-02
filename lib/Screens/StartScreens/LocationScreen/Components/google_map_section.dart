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
      builder: (context, provider, _) {
        final initialPosition = provider.kGooglePlex;
        final markerPosition = LatLng(
          initialPosition.target.latitude,
          initialPosition.target.longitude,
        );

        return GestureDetector(
          child: RepaintBoundary(
            child: GoogleMap(
              initialCameraPosition: initialPosition,
              markers: {
                Marker(
                  markerId: const MarkerId("1"),
                  position: markerPosition,
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                if (!provider.gController.isCompleted) {
                  provider.gController.complete(controller);
                }
              },
              gestureRecognizers: {
                Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
                Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
                Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer()),
              },
            ),
          ),
        );
      },
    );
  }
}
