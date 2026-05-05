import 'package:guitar_eik/logic/chord/chord_cubit.dart';
import 'package:guitar_eik/presentation/widgets/components/chord_content.dart';
import 'package:guitar_eik/presentation/widgets/components/chord_screen_app_bar.dart';
import 'package:guitar_eik/presentation/widgets/utils/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChordScreen extends StatefulWidget {
  const ChordScreen({super.key});

  @override
  State<ChordScreen> createState() => _ChordScreenState();
}

class _ChordScreenState extends State<ChordScreen> {
  bool _isDataLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      context.read<ChordCubit>().load(id);
      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChordScreenAppBar(),
      floatingActionButton: BlocBuilder<ChordCubit, ChordState>(
        builder: (context, state) {
          bool isScrolling = false;
          if (state is ChordLoaded) isScrolling = state.isScrolling;
          return FloatingActionButton(
            onPressed: () {
              context.read<ChordCubit>().toggleScroll();
            },
            child: Icon(isScrolling ? Icons.pause : Icons.play_arrow, size: 35),
          );
        },
      ),
      body: BlocBuilder<ChordCubit, ChordState>(
        builder: (context, state) {
          if (state is ChordLoading) {
            return LoadingView();
          } else if (state is ChordLoaded) {
            return ChordContent();
          }
          return const Center(child: Text("Data မရှိသေးပါ"));
        },
      ),
    );
  }
}
