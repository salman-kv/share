import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';

class UserMapPage extends StatelessWidget {
  LatLng? userPosition;
  var initialCameraPosition =
      const CameraPosition(target: LatLng(12.44, 20.445), zoom: 14);
  Set<Marker> marker = {};
  GoogleMapController? _controller;

  UserMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        mapType: MapType.normal,
        markers: marker,
        onMapCreated: (controller) {
          _controller = controller;
          log('${BlocProvider.of<SearchBloc>(context).position}');
          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 14,
                target: LatLng(
                    BlocProvider.of<SearchBloc>(context).position!.latitude,
                    BlocProvider.of<SearchBloc>(context).position!.longitude),
              ),
            ),
          );
          marker.add(
            Marker(
              markerId: MarkerId('user location'),
              position: LatLng(
                  BlocProvider.of<SearchBloc>(context).position!.latitude,
                  BlocProvider.of<SearchBloc>(context).position!.longitude),
            ),
          );
          log('${BlocProvider.of<SearchBloc>(context).listRoomModel}');
          if (BlocProvider.of<SearchBloc>(context).listRoomModel.isNotEmpty) {
            List.generate(
                BlocProvider.of<SearchBloc>(context).listRoomModel.length,
                (index) {
              marker.add(Marker(
                  markerId: MarkerId(
                      '${BlocProvider.of<SearchBloc>(context).listRoomModel[index].roomNumber}'),
                  position: BlocProvider.of<SearchBloc>(context)
                      .listRoomModel[index]
                      .latlng!));
            });
          }
          // setState(() {});
        },
      ),
    );
  }
}
