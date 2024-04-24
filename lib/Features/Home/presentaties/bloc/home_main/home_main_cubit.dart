import 'package:bloc/bloc.dart';

part 'home_main_state.dart';

class HomeMainCubit extends Cubit<HomeMainState> {
  HomeMainCubit() : super(HomeMainState(status: News()));

  changeState(int value) {
    switch (value) {
      case 0:
        emit(HomeMainState(status: News()));
        break;
      case 1:
        emit(HomeMainState(status: Speech()));
        break;
      case 2:
        emit(HomeMainState(status: Sermon()));
        break;
      case 3:
        emit(HomeMainState(status: Article()));
        break;
      default:
    }
  }
}
