
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/aplication/map_bloc/map_bloc.dart';
import 'package:share/user/aplication/map_bloc/map_event.dart';
import 'package:share/user/aplication/map_bloc/map_state.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class UserMapPage extends StatelessWidget {
  UserMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(),
      child: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MapInitialState) {
            BlocProvider.of<MapBloc>(context)
                .add(OnFechHotelDeatailsEvent(context: context));
            return  Center(
              child: CommonWidget().loadingWidget(),
            );
          } else {
            return context.watch<MapBloc>().marker.isEmpty
                ? SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Finding Rooms near by you . . .',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        CommonWidget().loadingWidget(),
                      ],
                    ),
                  )
                : Scaffold(
                    body: GoogleMap(
                      initialCameraPosition:
                          context.read<MapBloc>().initialCameraPosition,
                      mapType: MapType.normal,
                      markers: context.read<MapBloc>().marker,
                      onMapCreated: (controller) {
                        context.read<MapBloc>().controller = controller;
                        BlocProvider.of<MapBloc>(context)
                            .add(OnCamaraPositionChangeEvent());
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
