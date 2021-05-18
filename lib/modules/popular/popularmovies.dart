import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/layout/movielayout/bloc/moviecubit.dart';
import 'package:movieapp/layout/movielayout/bloc/moviestate.dart';
import 'package:movieapp/modules/details/bloc/detailscubit.dart';
import 'package:movieapp/shared/components/component.dart';


import '../details/Details.dart';


class PopularMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MovieState>(
        listener: (context, state) {},
        builder: (context,  MovieState state) {
          var cubit = MoviesCubit.get(context);
          var height=MediaQuery.of(context).size.height;
          var width=MediaQuery.of(context).size.width;
          print(height);
          print(width);
          return Scaffold(
            body: ConditionalBuilder(
              condition:state is !MoviePopularLoadingState ,
              builder:(context)=> GridView.count(crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: width/width/height/height+.63,
                children: List.generate(cubit.popularmovies.result.length, (index) {
                  // ignore: deprecated_member_use
                  return GestureDetector(child: buildMovie(cubit.popularmovies.result[index],context),
                  onTap: (){
                    MoviesDetailsCubit.get(context).getvideo(movieId:cubit.popularmovies.result[index].id );

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => DetailsMovie(cubit.popularmovies.result[index])));
                  },);
                }),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
            )
          );
        });
  }



}
