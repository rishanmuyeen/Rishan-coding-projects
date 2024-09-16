import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/appbar/appbar.dart';
import 'package:musicapp/common/widgets/favouriteButton/favpurite_button.dart';
import 'package:musicapp/core/configs/contants/app_urls.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/domain/entities/songs/song.dart';
import 'package:musicapp/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:musicapp/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key,required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        action: IconButton(
          onPressed: (){}, 
          icon: const Icon(Icons.more_vert_rounded)
        ),
        title: const Text(
          "Now Playing",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),  
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          '${AppUrls.songFirestorage}${songEntity.title}.mp3?${AppUrls.mediaAlt}' 
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            child: Column(
              children: [
                _song_cover(context),
                const SizedBox(height: 20,),
                _song_detail(),
                const SizedBox(height: 20,),
                song_player(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _song_cover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
          '${AppUrls.firestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppUrls.mediaAlt}'
          )
        ) 
      ),
    );
  }

  Widget _song_detail(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ],
        ),
        FavouriteButton(
          songEntity: songEntity,
        ) 
      ],
    );
  }
  Widget song_player(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  context.read<SongPlayerCubit>().seek(Duration(seconds: value.toInt()));
                },
                activeColor: AppColors.primary,
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition
                    )
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().play_or_pause(); 
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing? Icons.pause : Icons.play_arrow_rounded
                  ),
                ),
              )
            ],
          );
        } 
        // Fallback for other states
        return Container(); // Handle any other states by returning an empty container or some default UI
      },
    );
  }
  String formatDuration(Duration duration){
    final mintues = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${mintues.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}