import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/moviecubit.dart';
import 'bloc/moviestate.dart';

class MovieLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.models[cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBotomNav(index);
              },
              items: cubit.Modules,
            ),
            body: cubit.screens[cubit.currentIndex],

          );
        });
  }
}
