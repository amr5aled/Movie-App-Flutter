import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/modules/details/bloc/detailsState.dart';
import 'package:movieapp/modules/details/bloc/detailscubit.dart';
import 'package:movieapp/shared/components/component.dart';
import 'package:movieapp/shared/components/constraint.dart';

class FavouriteMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesDetailsCubit()..newtasks;
    return BlocConsumer<MoviesDetailsCubit, MovieDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesDetailsCubit.get(context).newtasks;

          return Scaffold(
            body: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1 / 1.73,
              children: List.generate(cubit.length, (index) {
                return buildMovies(cubit[index], context);
              }),
            ),
          );
        });
  }

  Widget buildMovies(Map<String, dynamic> cubit, BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                Poster + '${cubit['image']}',
                fit: BoxFit.fitWidth,
                height: 190,
                width: 160,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Text(
                  '${cubit['title']}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Text(
                      '${cubit['vote']}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 26,
                      ),
                      onPressed: () {
                        MoviesDetailsCubit.get(context).delete(id: cubit['id']);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
