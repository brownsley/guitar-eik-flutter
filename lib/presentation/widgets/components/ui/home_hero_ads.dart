import 'dart:async';

import 'package:flutter/material.dart';

class HomeHeroAds extends StatefulWidget {
  const HomeHeroAds({super.key});

  @override
  State<HomeHeroAds> createState() => _HomeHeroAdsState();
}

class _HomeHeroAdsState extends State<HomeHeroAds> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> adData = [
    {
      "title": "PREMIUM HEADPHONES",
      "subtitle": "Get 20% off on Sony & Bose",
      "image":
          "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000",
      "url": "https://example.com/shop",
    },
    {
      "title": "CLOTHING BRAND",
      "subtitle": "New Summer Collection Out Now",
      "image":
          "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000",
      "url": "https://example.com/fashion",
    },
    {
      "title": "SMART WATCH SERIES",
      "subtitle": "Track your rhythm and health",
      "image":
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000",
      "url": "https://example.com/tech",
    },
    {
      "title": "COFFEE ROASTERS",
      "subtitle": "Fresh beans delivered to your door",
      "image":
          "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=1000",
      "url": "https://example.com/coffee",
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < adData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Colors.deepPurpleAccent;

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: adData.length,
            itemBuilder: (context, index) {
              return _buildAdItem(adData[index], accentColor);
            },
          ),
        ),
        const SizedBox(height: 10),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            adData.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              width: _currentPage == index ? 20 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? accentColor
                    : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdItem(Map<String, String> data, Color accent) {
    return GestureDetector(
      onTap: () {
        // Ads link ဆီသို့ သွားရန် code ထည့်နိုင်သည်
        debugPrint("Navigating to: ${data['url']}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(data['image']!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // AD label tag
            PositionImage(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  "SPONSORED",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Ad content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      data['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['subtitle']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper for AD Tag position
class PositionImage extends StatelessWidget {
  final double? top, right;
  final Widget child;
  const PositionImage({super.key, this.top, this.right, required this.child});
  @override
  Widget build(BuildContext context) =>
      Positioned(top: top, right: right, child: child);
}
