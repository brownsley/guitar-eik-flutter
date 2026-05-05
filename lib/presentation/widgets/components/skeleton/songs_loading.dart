import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class SongsLoading extends StatelessWidget {
  const SongsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: SkeletonParagraph(style: SkeletonParagraphStyle(lines: 3)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: SkeletonParagraph(style: SkeletonParagraphStyle(lines: 3)),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
