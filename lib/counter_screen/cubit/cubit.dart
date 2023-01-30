import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksblok/counter_screen/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterIntialState());
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState(counter: counter));
  }

  void plus() {
    counter++;
    emit(CounterplusState(counter: counter));
  }
}
