import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/layout/movielayout/bloc/moviecubit.dart';
import 'package:movieapp/layout/movielayout/bloc/moviestate.dart';
import 'package:movieapp/modules/details/bloc/detailscubit.dart';
import 'package:movieapp/shared/components/component.dart';

import '../details/Details.dart';

class UnComingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MovieState>(
        listener: (context, state) {},
        builder: (context,  MovieState state) {
          var cubit = MoviesCubit.get(context);
          return Scaffold(
              body: ConditionalBuilder(
                condition:state is !MovieTopRatedLoadingState ,
                builder:(context)=> GridView.count(crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: 1/1.58,
                  children: List.generate(cubit.uncomingmovies.result.length, (index) {
                    return GestureDetector(child: buildMovie(cubit.uncomingmovies.result[index],context),
                      onTap: (){
                        MoviesDetailsCubit.get(context).getvideo(movieId:cubit.uncomingmovies.result[index].id );
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => DetailsMovie(cubit.uncomingmovies.result[index])));
                      },);
                  }),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
              )
          );
        });
  }
}
