import 'package:flutter/material.dart';
import 'package:movieapp/layout/movielayout/bloc/moviecubit.dart';
import 'package:movieapp/models/moviemodel.dart';
import 'package:movieapp/modules/details/Details.dart';
import 'package:movieapp/shared/components/constraint.dart';

Widget buildMovie(Data result, context) {
  return RefreshIndicator(
    onRefresh:(){ print('refreshing stocks.....');},
    child: Card(
      semanticContainer: true,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              Poster + '${result.posterPath}',
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
                result.originalTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            if (result.voteAverage != 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Text(
                  '${result.voteAverage}',
                  style: TextStyle(color: Colors.blue),
                ),
              )
          ],
        ),
      ),
    ),
  );
}