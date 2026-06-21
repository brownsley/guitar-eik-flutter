import 'package:chord_diagrams/chord_diagrams.dart';
import 'package:flutter/material.dart';

class ChordDiragram extends StatefulWidget {
  const ChordDiragram({super.key});

  @override
  State<ChordDiragram> createState() => _ChordDiragramState();
}

class _ChordDiragramState extends State<ChordDiragram> {
  Instrument _instrument = Instrument.guitar;
  String _note = 'G';
  String _suffix = '';
  int _position = 0;
  bool _showAllPositions = false;
  bool _showAllChords = false;

  ThemeData get theme => Theme.of(context);
  ColorScheme get colorScheme => theme.colorScheme;

  late final List<String> _notes = ChordDiagrams.getNotes();

  List<String> get _availableSuffixes =>
      ChordDiagrams.getSuffixes(_note, instrument: _instrument);

  String get _chord => '$_note$_suffix';

  int get _positionCount =>
      ChordDiagrams.getPositionCount(_chord, instrument: _instrument);

  void _selectInstrument(Instrument instrument) {
    setState(() {
      _instrument = instrument;
      if (!_availableSuffixes.contains(_suffix)) _suffix = '';
      if (_position >= _positionCount) _position = 0;
    });
  }

  void _selectNote(String note) {
    setState(() {
      _note = note;
      if (!_availableSuffixes.contains(_suffix)) _suffix = '';
      if (_position >= _positionCount) _position = 0;
    });
  }

  void _selectSuffix(String suffix) {
    setState(() {
      _suffix = suffix;
      if (_position >= _positionCount) _position = 0;
    });
  }

  Widget _buildChip({
    required String label,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => onPressed(),
      backgroundColor: colorScheme.surfaceContainerLow,
      selectedColor: colorScheme.primary,
      side: BorderSide(
        color: selected ? colorScheme.primary : colorScheme.outlineVariant,
        width: 1,
      ),
      labelStyle: TextStyle(
        color: selected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    final suffixes = _availableSuffixes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'CHORD LIBRARY',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SegmentedButton<Instrument>(
              segments: const [
                ButtonSegment(value: Instrument.guitar, label: Text('Guitar')),
                ButtonSegment(
                  value: Instrument.ukulele,
                  label: Text('Ukulele'),
                ),
              ],
              selected: {_instrument},
              onSelectionChanged: (s) => _selectInstrument(s.first),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context).colorScheme.primary;
                  }
                  return Theme.of(context).colorScheme.surfaceContainerLow;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context).colorScheme.onPrimary;
                  }
                  return Theme.of(context).colorScheme.onSurfaceVariant;
                }),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _notes.map((note) {
                return _buildChip(
                  label: note,
                  selected: _note == note,
                  onPressed: () => _selectNote(note),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DropdownButton<String>(
                  value: suffixes.contains(_suffix) ? _suffix : '',
                  dropdownColor: const Color(0xFF1C2A36),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  underline: Container(
                    height: 1,
                    color: const Color(0xFF35505F),
                  ),
                  items: suffixes.map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(s.isEmpty ? 'major' : s),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) _selectSuffix(v);
                  },
                ),
                ...List.generate(_positionCount, (i) {
                  return _buildChip(
                    label: '$i',
                    selected:
                        !_showAllPositions && !_showAllChords && _position == i,
                    onPressed: () => setState(() {
                      _showAllPositions = false;
                      _showAllChords = false;
                      _position = i;
                    }),
                  );
                }),
                _buildChip(
                  label: 'All Positions',
                  selected: _showAllPositions,
                  onPressed: () => setState(() {
                    _showAllPositions = !_showAllPositions;
                    _showAllChords = false;
                  }),
                ),
                _buildChip(
                  label: 'All Chords',
                  selected: _showAllChords,
                  onPressed: () => setState(() {
                    _showAllChords = !_showAllChords;
                    _showAllPositions = false;
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_showAllPositions)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: _positionCount,
                  itemBuilder: (context, index) {
                    return ChordDiagram(
                      chord: _chord,
                      position: index,
                      instrument: _instrument,
                    );
                  },
                ),
              )
            else if (_showAllChords)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 160,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: suffixes.length,
                  itemBuilder: (context, index) {
                    final s = suffixes[index];
                    return ChordDiagram(
                      chord: '$_note$s',
                      instrument: _instrument,
                    );
                  },
                ),
              )
            else ...[
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: ChordDiagram(
                    chord: _chord,
                    position: _position,
                    instrument: _instrument,
                    width: 300,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
