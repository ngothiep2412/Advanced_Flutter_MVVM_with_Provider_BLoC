import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        MyAppIcons.favoriteOutlineRounded,
        color: Colors.red,
        size: 20,
      ),
    );
  }
}
