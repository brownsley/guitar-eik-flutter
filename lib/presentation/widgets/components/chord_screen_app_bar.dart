import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/chord/chord_cubit.dart';
import 'package:guitar_eik/logic/favorite/favorite_cubit.dart';
import 'package:guitar_eik/model/song.dart';
import 'package:guitar_eik/presentation/widgets/utils/form_dailog.dart';

import 'setup_box.dart';

class ChordScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChordScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "CHORD",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          fontSize: 14,
        ),
      ),
      actions: [
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            final chordState = context.watch<ChordCubit>().state;
            if (chordState is ChordLoaded) {
              final songData = chordState.song;
              final isFavorite = context.read<FavoriteCubit>().isFavorite(
                songData.id,
              );
              return IconButton(
                onPressed: () {
                  final songToSave = Song(
                    id: songData.id,
                    title: songData.title,
                    totalView: songData.totalView,
                    artists: (songData.artists as List)
                        .map((e) => e.toString())
                        .toList(),
                    lyric: songData.lyric ?? '',
                  );
                  context.read<FavoriteCubit>().toggleFavorite(songToSave);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorite ? Colors.redAccent : Colors.grey,
                ),
              );
            }
            return const SizedBox();
          },
        ),
        IconButton(
          onPressed: () {
            final state = context.read<ChordCubit>().state;
            if (state is ChordLoaded) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FormDailog(
                    title: "Testing TItle",
                    subjectLabel: "Sub Label",
                    descLabel: "Desc Lable",
                    onSubmit: () {},
                  );
                },
              );
            }
          },
          icon: Icon(Icons.flag_outlined),
        ),
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                final chordCubit = BlocProvider.of<ChordCubit>(context);
                showModalBottomSheet(
                  context: context,
                  builder: (modalContext) => BlocProvider.value(
                    value: chordCubit,
                    child: const SetupBox(),
                  ),
                );
              },
              icon: const Icon(Icons.tune_rounded),
            );
          },
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
