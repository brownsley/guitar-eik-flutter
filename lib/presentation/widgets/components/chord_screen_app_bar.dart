import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/chord/chord_cubit.dart';

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
        IconButton(
          onPressed: () {
            final state = context.read<ChordCubit>().state;
            if (state is ChordLoaded) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Chord Loaded"),
                    content: Text("The chord data is ready."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    ],
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
