import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:guitar_eik/core/theme/extension.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

import '../../../logic/chord/chord_cubit.dart';

class ChordContent extends StatelessWidget {
  const ChordContent({super.key});

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<AppColorsExtension>()!;
    return BlocBuilder<ChordCubit, ChordState>(
      builder: (context, state) {
        if (state is! ChordLoaded) {
          return LoadingView();
        }
        return Container(
          padding: const EdgeInsets.all(20),
          color: Colors.transparent,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification &&
                  notification.direction != ScrollDirection.idle) {
                if (state.isScrolling) {
                  context.read<ChordCubit>().toggleScroll();
                }
              }
              if (notification.metrics.extentAfter < 5.0) {
                if (state.isScrolling) {
                  context.read<ChordCubit>().toggleScroll();
                }
              }
              return false;
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) {
                context.read<ChordCubit>().toggleScroll();
              },
              child: LyricsRenderer(
                leadingWidget: Column(
                  children: [
                    Text(
                      state.song.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 4,
                          height: 20,
                          color: Colors.deepPurpleAccent,
                        ),
                        Expanded(
                          child: Text(
                            (state.song.artists != null &&
                                    state.song.artists!.isNotEmpty)
                                ? state.song.artists!.join(", ")
                                : "Unknown",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                lyrics: state.song.lyric!,
                textStyle: TextStyle(color: myColors.lyricColor, fontSize: 15),
                chordStyle: const TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 15,
                ),
                onTapChord: () {},
                transposeIncrement: state.transpose,
                scrollSpeed: state.isScrolling ? state.speed : 0,
              ),
            ),
          ),
        );
      },
    );
  }
}
