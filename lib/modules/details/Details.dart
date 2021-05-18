import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/models/moviemodel.dart';
import 'package:movieapp/models/videos.dart';
import 'package:movieapp/shared/components/constraint.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/detailsState.dart';
import 'bloc/detailscubit.dart';

class DetailsMovie extends StatefulWidget {
  DetailsMovie(this.result);
  final Data result;
  bool iscolor = false;

  @override
  _DetailsMovieState createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {
  @override
  void initState() {
    MoviesDetailsCubit()
      ..getvideo(movieId: widget.result.id).then((value) {
        print(value);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesDetailsCubit, MovieDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MoviesDetailsCubit.get(context);

          return Scaffold(
              appBar: AppBar(
                title: Text(widget.result.title),
              ),
              body: ConditionalBuilder(
                condition: state is MovieDetailsSucessState||state is GetDataBaseState,
                builder: (context) => buildDetails(context),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        });
  }

  Widget buildDetails(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          Poster + '${widget.result.posterPath}',
          fit: BoxFit.fill,
          height: 250,
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.result.title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                '${widget.result.voteAverage}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Spacer(),
            Container(
              color: widget.iscolor ? Colors.red : Colors.grey,
              child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    size: 26,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.iscolor = !widget.iscolor;
                    });
                    if (widget.iscolor)
                      MoviesDetailsCubit.get(context)
                          .insertToDatabase(
                              id: widget.result.id,
                              image: '${widget.result.posterPath}',
                              title: widget.result.title,
                              vote: widget.result.voteAverage)
                          .then((value) {});
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            widget.result.releaseDate,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  widget.result.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),

                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildvideo(
                          MoviesDetailsCubit.get(context).video.tailer[index], index),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 30,
                          ),
                      itemCount:
                          MoviesDetailsCubit.get(context).video.tailer.length),
                  // ignore: deprecated_member_use
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildvideo(Movies tailer,int index) {
    return SizedBox(
      width: 80,
      height: 8,
      child: RaisedButton(
        color: Colors.indigo,
        onPressed: () => _launchURL(tailer.key),
        child: Text('video${index+1}',style: TextStyle(color: Colors.white),),
      ),
    );
  }

  void _launchURL(String key) async =>
      await canLaunch('https://www.youtube.com/watch?v=$key')
          ? await launch('https://www.youtube.com/watch?v=$key')
          : throw 'Could not launch';
}
