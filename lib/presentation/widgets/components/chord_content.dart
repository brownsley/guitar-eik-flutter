import 'package:chord_diagrams/chord_diagrams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:guitar_eik/core/theme/extension.dart';
import 'package:guitar_eik/presentation/widgets/components/chord_list.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';

import '../../../logic/chord/chord_cubit.dart';

class ChordContent extends StatefulWidget {
  const ChordContent({super.key});

  @override
  State<ChordContent> createState() => _ChordContentState();
}

class _ChordContentState extends State<ChordContent> {
  Instrument _currentInstrument = Instrument.guitar;

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<AppColorsExtension>()!;

    return BlocBuilder<ChordCubit, ChordState>(
      builder: (context, state) {
        if (state is! ChordLoaded) {
          return LoadingView();
        }

        return IgnorePointer(
          ignoring: state.isScrolling,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: LyricsRenderer(
              leadingWidget: Column(
                children: [
                  ChordList(
                    lyric: state.song.lyric!,
                    transpose: state.transpose,
                    initialInstrument: _currentInstrument,
                    onInstrumentChanged: (newInst) {
                      setState(() {
                        _currentInstrument = newInst;
                      });
                    },
                  ),
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
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              onTapChord: (chord) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        width: 200,
                        height: 200,
                        child: Card(
                          color: Colors.white,
                          elevation: 2,
                          margin: EdgeInsets.zero,
                          child: Center(
                            child: ChordDiagram(
                              chord: chord,
                              instrument: _currentInstrument,
                              width: 160,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              transposeIncrement: state.transpose,
              scrollSpeed: state.isScrolling ? state.speed : 0,
            ),
          ),
        );
      },
    );
  }
}
