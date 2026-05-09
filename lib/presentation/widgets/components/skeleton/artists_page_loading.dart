import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class ArtistPageLoading extends StatelessWidget {
  const ArtistPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 17),
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
                    const SizedBox(height: 10),
                    const SkeletonLine(
                      style: SkeletonLineStyle(height: 15, randomLength: false),
                    ),
                    const SizedBox(height: 8),
                    const SkeletonLine(
                      style: SkeletonLineStyle(height: 12, randomLength: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
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
                    const SizedBox(height: 10),
                    const SkeletonLine(
                      style: SkeletonLineStyle(height: 12, randomLength: false),
                    ),
                    const SizedBox(height: 8),
                    const SkeletonLine(
                      style: SkeletonLineStyle(height: 10, randomLength: true),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
        );
      },
    );
  }
}
