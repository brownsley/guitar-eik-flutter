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
          color: myColors.lyricBackground,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is UserScrollNotification) {
                if (notification.direction != ScrollDirection.idle) {
                  if (state.isScrolling) {
                    context.read<ChordCubit>().toggleScroll();
                  }
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
              onTap: () {
                context.read<ChordCubit>().toggleScroll();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: LyricsRenderer(
                  leadingWidget: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            state.song.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 10),

                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                width: 4,
                                height: 20,
                                color: Colors.deepPurpleAccent,
                              ),
                              Expanded(
                                child: Text(
                                  (state.song.artists != null &&
                                          state.song.artists!.isNotEmpty)
                                      ? state.song.artists!
                                            .map((a) => a.name)
                                            .join(", ")
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
                        ],
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                  lyrics: state.song.lyric!,
                  textStyle: TextStyle(
                    color: myColors.lyricColor,
                    fontSize: 15,
                  ),
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
          ),
        );
      },
    );
  }
}
