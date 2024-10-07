import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/screens/movies_detail_screen.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/cached_image.dart';
import 'package:mvvm_statemanagements/widgets/movies/favorite_btn.dart';
import 'package:mvvm_statemanagements/widgets/movies/genres_widget.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({
    super.key,
    required this.movieModel,
  });

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            getIt<NavigationService>().navigate(
              MoviesDetailScreen(
                movieModel: movieModel,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: movieModel.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedImagedWidget(
                        imgUrl:
                            'https://image.tmdb.org/t/p/w500/${movieModel.backdropPath}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieModel.originalTitle,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                                '${movieModel.voteAverage.toStringAsFixed(1)}/10'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenresListWidget(
                          movieModel: movieModel,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MyAppIcons.watchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              movieModel.releaseDate,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteBtnWidget(
                              movieModel: movieModel,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
