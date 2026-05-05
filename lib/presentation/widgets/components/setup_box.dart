import 'package:guitar_eik/logic/chord/chord_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/setup_button.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupBox extends StatefulWidget {
  const SetupBox({super.key});

  @override
  State<SetupBox> createState() => _SetupBoxState();
}

class _SetupBoxState extends State<SetupBox> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChordCubit, ChordState>(
      builder: (context, state) {
        if (state is! ChordLoaded) {
          return LoadingView();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text(
                      "Scroll Speed",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SetupButton(
                    icon: Icons.remove,
                    onPressed: () => {context.read<ChordCubit>().removeSpeed()},
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 5,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 9,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 15,
                        ),
                      ),
                      child: Slider(
                        value: state.speed.toDouble(),
                        min: 3,
                        max: 30,
                        divisions: 27,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black12,
                        onChanged: (value) => context
                            .read<ChordCubit>()
                            .updateSpeed(value.toInt()),
                      ),
                    ),
                  ),
                  SetupButton(
                    icon: Icons.add,
                    onPressed: () {
                      context.read<ChordCubit>().addSpeed();
                    },
                  ),
                  SizedBox(
                    width: 35,
                    child: Text(
                      state.speed.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const Divider(height: 25, thickness: 1),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      "Transpose",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SetupButton(
                    icon: Icons.exposure_minus_1,
                    onPressed: () => {
                      context.read<ChordCubit>().updateTranspose(-1),
                    },
                  ),
                  Expanded(
                    child: Text(
                      state.transpose.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SetupButton(
                    icon: Icons.plus_one,
                    onPressed: () => {
                      context.read<ChordCubit>().updateTranspose(1),
                    },
                  ),
                  SetupButton(
                    icon: Icons.refresh,
                    onPressed: () => {
                      context.read<ChordCubit>().resetTranspose(),
                    },
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
