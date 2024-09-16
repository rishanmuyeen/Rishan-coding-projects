import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicapp/common/helper/is_dark_mode.dart';
import 'package:musicapp/common/widgets/appbar/appbar.dart';
import 'package:musicapp/common/widgets/favouriteButton/favpurite_button.dart';
import 'package:musicapp/core/configs/contants/app_urls.dart';
import 'package:musicapp/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:musicapp/presentation/profile/bloc/profile_info_state.dart';
import 'package:musicapp/presentation/song_player/bloc/favourite_song_cubit.dart';
import 'package:musicapp/presentation/song_player/bloc/favourite_song_state.dart';
import 'package:musicapp/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    print("Picking image...");
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("Image selected: ${pickedFile.path}");
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print("No image selected.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundcolor: Colors.grey[600],
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          profileInfo(context),
          const SizedBox(height: 30),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey[600] : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _imageFile != null
                              ? FileImage(_imageFile!)
                              : NetworkImage(
                                  state.userEntity.imageUrl ?? 'path/to/placeholder_image.jpg',
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(state.userEntity.email ?? 'No email provided'),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.username ?? 'No username provided',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return const Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORITE SONGS'),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  if (state.favoriteSongs.isEmpty) {
                    return const Text('You have no favorite songs yet.');
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerPage(
                                songEntity: state.favoriteSongs[index],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${AppUrls.firestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      state.favoriteSongs[index].artist,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration
                                      .toString()
                                      .replaceAll('.', ':'),
                                ),
                                const SizedBox(width: 20),
                                FavouriteButton(
                                  songEntity: state.favoriteSongs[index],
                                  key: UniqueKey(),
                                  function: () {
                                    context
                                        .read<FavoriteSongsCubit>()
                                        .removeSong(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return const Text('Please try again.');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
