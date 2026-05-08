import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class ArtistListLoading extends StatelessWidget {
  const ArtistListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15),

        Expanded(
          child: Column(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: 160,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              SkeletonLine(style: SkeletonLineStyle(randomLength: false)),
              SizedBox(height: 10),
              SkeletonLine(style: SkeletonLineStyle(randomLength: true)),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: 160,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 10),
              SkeletonLine(style: SkeletonLineStyle(randomLength: false)),
              SizedBox(height: 10),
              SkeletonLine(style: SkeletonLineStyle(randomLength: true)),
            ],
          ),
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
