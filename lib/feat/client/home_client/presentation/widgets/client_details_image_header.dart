import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';

class ClientDetailsImageHeader extends StatefulWidget {
  final List<String> images;
  final bool isAvailable;

  const ClientDetailsImageHeader({
    super.key,
    required this.images,
    required this.isAvailable,
  });

  @override
  State<ClientDetailsImageHeader> createState() =>
      _ClientDetailsImageHeaderState();
}

class _ClientDetailsImageHeaderState extends State<ClientDetailsImageHeader> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage(int total) {
    if (_currentPage < total - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousImage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images.isNotEmpty ? widget.images : [''];

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          // PageView for swiping images
          PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final url = images[index];
              if (url.isEmpty) {
                return Container(
                  color: AppColors.lightBg,
                  child: const Center(
                    child: Icon(
                      Icons.apartment_rounded,
                      size: 80,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                );
              }
              return Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.lightBg,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),

          // Gradient shadow overlay wrapped in IgnorePointer to allow swipe gestures
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.45),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black.withValues(alpha: 0.45),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // Availability status badge
          Positioned(
            top: 40,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.isAvailable
                    ? AppColors.primaryGreen
                    : Colors.red.shade700,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isAvailable ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.isAvailable ? 'متاحة للتأجير' : 'غير متاحة',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Next / Previous buttons if multiple images
          if (images.length > 1) ...[
            if (_currentPage > 0)
              Positioned(
                left: 12,
                top: 130,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white, size: 16),
                    onPressed: _previousImage,
                  ),
                ),
              ),
            if (_currentPage < images.length - 1)
              Positioned(
                right: 12,
                top: 130,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white, size: 16),
                    onPressed: () => _nextImage(images.length),
                  ),
                ),
              ),
          ],

          // Counter badge (e.g. 1/3)
          if (images.length > 1)
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_currentPage + 1} / ${images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Page indicators
          if (images.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 7,
                      width: _currentPage == index ? 24 : 7,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.primaryGreen
                            : Colors.white.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
