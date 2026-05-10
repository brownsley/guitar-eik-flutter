import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArtistsListLoading extends StatelessWidget {
  final int itemCount;
  const ArtistsListLoading(this.itemCount, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color baseColor = isDark ? Colors.grey[900]! : Colors.grey[300]!;
    final Color highlightColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 15),

                const Expanded(child: _ArtistSkeletonItem()),

                const SizedBox(width: 10),

                const Expanded(child: _ArtistSkeletonItem()),

                const SizedBox(width: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ArtistSkeletonItem extends StatelessWidget {
  const _ArtistSkeletonItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),

        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
