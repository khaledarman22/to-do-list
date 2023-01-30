abstract class CounterStates {}

class CounterIntialState extends CounterStates {}

class CounterMinusState extends CounterStates {
  final counter;
  CounterMinusState({this.counter});
}

class CounterplusState extends CounterStates {
  final counter;
  CounterplusState({this.counter});
}
