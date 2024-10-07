import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/screens/movies_detail_screen.dart';
import 'package:mvvm_statemanagements/services/init_getIt.dart';
import 'package:mvvm_statemanagements/services/navigation_service.dart';
import 'package:mvvm_statemanagements/widgets/cached_image.dart';
import 'package:mvvm_statemanagements/widgets/movies/favorite_btn.dart';
import 'package:mvvm_statemanagements/widgets/movies/genres_widget.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            getIt<NavigationService>().navigate(const MoviesDetailScreen());
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: const CachedImagedWidget(
                        imgUrl: MyAppConstants.movieImage),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Movie Title',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("8/10"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const GenresListWidget(),
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
                            const Text(
                              'Release Date',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            const FavoriteBtnWidget(),
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
