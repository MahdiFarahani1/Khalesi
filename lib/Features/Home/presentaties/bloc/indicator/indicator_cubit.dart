import 'package:bloc/bloc.dart';

part 'indicator_state.dart';

class IndicatorCubit extends Cubit<IndicatorState> {
  IndicatorCubit() : super(IndicatorState(index: 0));

  changeState(int index) {
    emit(IndicatorState(index: index));
  }
}
