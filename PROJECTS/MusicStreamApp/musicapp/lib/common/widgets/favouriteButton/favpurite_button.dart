import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/bloc/favourite_button/favourite_button_cubit.dart';
import 'package:musicapp/common/bloc/favourite_button/favourite_button_state.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/domain/entities/songs/song.dart';

class FavouriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function ? function;
  const FavouriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
        builder: (context, state) {
          if (state is FavouriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  songEntity.songId,
                );
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: AppColors.grey,
              ),
            );
          } else if (state is FavouriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(
                  songEntity.songId,
                );
              },
              icon: Icon(
                state.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: AppColors.grey,
              ),
            );
          }
          return Container(); // Default case to handle other states
        },
      ),
    );
  }
}
