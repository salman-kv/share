import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_event.dart';
import 'package:share/user/aplication/main_user_bloc/main_user_state.dart';
import 'package:share/user/presentation/const/const_color.dart';

class MainUserBloc extends Bloc<MainUserEvent, MainUserState> {
  int index=0;
  MainUserBloc() : super(MainUserInitialState()) {
    on<OnNavBarClickedEvent>((event, emit) {
      index=event.index;
      emit(MainUserIndexChangedState());
    });
    on<OnColorChangeEvent>((event, emit) {
      log('color change');
      ConstColor().changeColor();
      emit(MainUserColorChangedState());
    });
  }
}