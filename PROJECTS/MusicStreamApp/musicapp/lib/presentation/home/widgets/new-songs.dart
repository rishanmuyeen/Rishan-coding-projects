import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/core/configs/contants/app_urls.dart';
import 'package:musicapp/core/configs/theme/appColor.dart';
import 'package:musicapp/domain/entities/songs/song.dart';
import 'package:musicapp/presentation/home/bloc/news_songs_cubit.dart';
import 'package:musicapp/presentation/home/bloc/news_songs_state.dart';
import 'package:musicapp/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatefulWidget {
  const NewsSongs({super.key});

  @override
  State<NewsSongs> createState() => _NewsSongsState();
}

class _NewsSongsState extends State<NewsSongs> {
  late final NewsSongsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = NewsSongsCubit()..getNewsSongs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }
            return const Center(child: Text('Failed to load songs'));
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    if (songs.isEmpty) {
      return const Center(child: Text('No songs available'));
    } else {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final imageUrl = '${AppUrls.firestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.mediaAlt}';
          return Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(songEntity: songs[index],)));
              } ,
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 40,
                            width: 40,
                            transform: Matrix4.translationValues(10,10,0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.grey
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    )
                    // Optional: add song title or artist here
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: songs.length,
      );
    }
  }
}
