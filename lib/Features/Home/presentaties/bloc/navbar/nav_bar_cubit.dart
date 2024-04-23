import 'package:bloc/bloc.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarState(index: 0));

  changeState(int index) {
    emit(NavBarState(index: index));
  }
}
