import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telegram_clone/utils/my_icons.dart';

class MapPage extends StatefulWidget {


  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}


class _MapPageState extends State<MapPage> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState(){
addCustomIcon();
super.initState();
  }
  void addCustomIcon(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration(), MyIcon.gps).then((icon) => {
      setState((){
        markerIcon = icon;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(61, 47),
          zoom: 14,

        ) ,
            markers: {
              Marker(markerId: MarkerId("demo"),
              position: LatLng(61, 47.1),
              draggable: true,
              onDragEnd: (value){

              } ,
                icon: markerIcon

          ),

              },

      ),

    );
  }
}
