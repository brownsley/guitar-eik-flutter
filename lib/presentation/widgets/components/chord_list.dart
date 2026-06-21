import 'package:chord_diagrams/chord_diagrams.dart';
import 'package:flutter/material.dart';

class ChordList extends StatefulWidget {
  final String lyric;
  final int transpose;
  final Instrument initialInstrument;
  final ValueChanged<Instrument> onInstrumentChanged;

  const ChordList({
    super.key,
    required this.lyric,
    required this.transpose,
    required this.initialInstrument,
    required this.onInstrumentChanged,
  });

  @override
  State<ChordList> createState() => _ChordListState();
}

class _ChordListState extends State<ChordList> {
  late Instrument _instrument = widget.initialInstrument;
  bool _showChords = true;

  final List<String> _sharpList = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];
  final List<String> _flatList = [
    'C',
    'Db',
    'D',
    'Eb',
    'E',
    'F',
    'Gb',
    'G',
    'Ab',
    'A',
    'Bb',
    'B',
  ];
  static final RegExp _chordRegex = RegExp(r'\[(.*?)\]');

  String _getRootNote(String chord) {
    final rootRegex = RegExp(r'^([A-G][#b]?)');
    final match = rootRegex.firstMatch(chord);
    return match != null ? match.group(1)! : '';
  }

  bool _isValidChord(String chord) {
    String root = _getRootNote(chord);
    return _sharpList.contains(root) || _flatList.contains(root);
  }

  List<String> _getUniqueChords(String text) {
    return _chordRegex
        .allMatches(text)
        .map((m) => m.group(1)!)
        .where((c) => _isValidChord(c))
        .toSet()
        .toList();
  }

  String _transposeChord(String chord, int amount) {
    bool isFlat = _flatList.contains(_getRootNote(chord));

    List<String> currentList = isFlat ? _flatList : _sharpList;
    String rootNote = _getRootNote(chord);

    int currentIndex = currentList.indexOf(rootNote);
    if (currentIndex == -1) return chord;

    int newIndex = (currentIndex + amount) % 12;
    if (newIndex < 0) newIndex += 12;

    String suffix = chord.substring(rootNote.length);

    return currentList[newIndex] + suffix;
  }

  void _selectInstrument(Instrument selectedInstrument) {
    if (_instrument != selectedInstrument) {
      setState(() {
        _instrument = selectedInstrument;
      });
      widget.onInstrumentChanged(selectedInstrument);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transposedChords = _getUniqueChords(
      widget.lyric,
    ).map((c) => _transposeChord(c, widget.transpose)).toList();

    return Column(
      children: [
        ListTile(
          title: const Text(
            "Used Chords",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(
              _showChords ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
            onPressed: () => setState(() => _showChords = !_showChords),
          ),
        ),

        if (_showChords) ...[
          SegmentedButton<Instrument>(
            segments: const [
              ButtonSegment(value: Instrument.guitar, label: Text('Guitar')),
              ButtonSegment(value: Instrument.ukulele, label: Text('Ukulele')),
            ],
            selected: {_instrument},
            onSelectionChanged: (Set<Instrument> newSelection) {
              _selectInstrument(newSelection.first);
            },
            style: SegmentedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),

          GridView.builder(
            padding: const EdgeInsets.all(5),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: .8,
            ),
            itemCount: transposedChords.length,
            itemBuilder: (context, index) {
              final double screenWidth = MediaQuery.of(context).size.width;

              final double diagramWidth = (screenWidth - 85) / 2;
              return Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ChordDiagram(
                      chord: transposedChords[index],
                      instrument: _instrument,
                      width: diagramWidth,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
