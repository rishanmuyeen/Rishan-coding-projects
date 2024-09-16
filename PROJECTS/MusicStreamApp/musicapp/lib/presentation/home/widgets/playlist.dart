import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/favouriteButton/favpurite_button.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/domain/entities/songs/song.dart';
import 'package:musicapp/presentation/home/bloc/play_list_cubit.dart';
import 'package:musicapp/presentation/home/bloc/play_list_state.dart';
import 'package:musicapp/presentation/song_player/pages/song_player.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          if (state is PlayListLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Playlist",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        "see more",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _songs(state.songs),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true, // Ensures ListView doesn't take infinite height
      physics: const NeverScrollableScrollPhysics(), // Disable ListView's scroll since SingleChildScrollView will handle it
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                            songEntity: songs[index],
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.grey),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          songs[index].artist,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(songs[index].duration
                        .toString()
                        .replaceAll('.', ':')),
                    const SizedBox(width: 20),
                    FavouriteButton(
                      songEntity: songs[index],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemCount: songs.length,
    );
  }
}
