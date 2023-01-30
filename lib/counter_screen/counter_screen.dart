import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksblok/constant/main_material_app.dart';
import 'package:tasksblok/counter_screen/cubit/cubit.dart';
import 'package:tasksblok/counter_screen/cubit/states.dart';

class CounterScreenView extends StatelessWidget {
  const CounterScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
                body: Container(
                  width: double.infinity,
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  CounterCubit.get(context).minus();
                                },
                                child: Text('-')),
                            const Spacer(),
                            Text(
                              '${CounterCubit.get(context).counter}',
                              style: TextStyle(fontSize: 40),
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  CounterCubit.get(context).plus();
                                },
                                child: Text('+')),
                            const Spacer(
                              flex: 2,
                            )
                          ])
                    ],
                  ),
                ),
              )),
    );
  }
}
