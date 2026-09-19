import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/constant/colors_app.dart';

class PropertyImagesUploader extends StatefulWidget {
  final ValueChanged<List<XFile>>? onImagesChanged;

  const PropertyImagesUploader({super.key, this.onImagesChanged});

  @override
  State<PropertyImagesUploader> createState() => _PropertyImagesUploaderState();
}

class _PropertyImagesUploaderState extends State<PropertyImagesUploader> {
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    try {
      final List<XFile> selected = await _picker.pickMultiImage();
      if (selected.isNotEmpty) {
        setState(() {
          _images.addAll(selected);
        });
        widget.onImagesChanged?.call(_images);
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    widget.onImagesChanged?.call(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Dashed Upload Container
        GestureDetector(
          onTap: _pickImages,
          child: DashedContainer(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(16),
            strokeWidth: 1.5,
            dashLength: 7.0,
            dashSpacing: 5.0,
            backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.03),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                // Camera Icon
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.primaryGreen,
                    size: 30,
                  ),
                ),
                const Gap(14),

                // Main Title
                const Text(
                  'أضف صور السكن كما تحب (بدون حد أقصى)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),

                // Subtitle / Guidance
                Text(
                  'أضف صور واضحة للشقة والغرف والمرافق لتسريع قبول الحجز.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
                const Gap(16),

                // Tip Banner
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF8),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.wb_sunny_outlined,
                        size: 16,
                        color: AppColors.primaryGreen,
                      ),
                      const Gap(8),
                      Text(
                        'يفضل تصوير الغرفة نهاراً بإضاءة طبيعية واضحة',
                        style: TextStyle(
                          color: AppColors.primaryGreen.withValues(alpha: 0.9),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Preview Area (Show when images are added)
        if (_images.isNotEmpty) ...[
          const Gap(16),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              reverse: true, // RTL friendly
              itemCount: _images.length + 1,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                // First item is the "Add More" tile
                if (index == 0) {
                  return GestureDetector(
                    onTap: _pickImages,
                    child: DashedContainer(
                      width: 130,
                      height: 160,
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(14),
                      strokeWidth: 1.5,
                      dashLength: 6.0,
                      dashSpacing: 4.0,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen.withValues(
                                  alpha: 0.1,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_photo_alternate_outlined,
                                color: AppColors.primaryGreen,
                                size: 26,
                              ),
                            ),
                            const Gap(10),
                            const Text(
                              'إضافة صور +',
                              style: TextStyle(
                                color: AppColors.primaryGreen,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // Uploaded Image card
                final imageIndex = index - 1;
                final file = _images[imageIndex];

                return Container(
                  width: 140,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // The Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: kIsWeb
                            ? Image.network(file.path, fit: BoxFit.cover)
                            : Image.file(
                                File(file.path),
                                fit: BoxFit.cover,
                              ),
                      ),

                      // Delete Button (Top Corner)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: GestureDetector(
                          onTap: () => _removeImage(imageIndex),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

/// A lightweight, custom-painted dashed container
class DashedContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final double strokeWidth;
  final double dashLength;
  final double dashSpacing;

  const DashedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.color = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
    this.strokeWidth = 1.0,
    this.dashLength = 5.0,
    this.dashSpacing = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: color,
          borderRadius: borderRadius,
          strokeWidth: strokeWidth,
          dashLength: dashLength,
          dashSpacing: dashSpacing,
        ),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final BorderRadius borderRadius;
  final double strokeWidth;
  final double dashLength;
  final double dashSpacing;

  _DashedBorderPainter({
    required this.color,
    required this.borderRadius,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = borderRadius.toRRect(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = _createDashedPath(path, dashLength, dashSpacing);

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashLength, double dashSpacing) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double length = draw ? dashLength : dashSpacing;
        if (distance + length > metric.length) {
          if (draw) {
            dest.addPath(
              metric.extractPath(distance, metric.length),
              Offset.zero,
            );
          }
          break;
        }
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashSpacing != dashSpacing;
  }
}
