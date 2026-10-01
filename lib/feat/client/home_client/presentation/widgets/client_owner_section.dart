import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/chat/data/chat_service.dart';
import 'package:sacny/feat/chat/presentation/widgets/chat_room_page_body.dart';

class ClientOwnerSection extends StatelessWidget {
  final String? ownerName;
  final String? ownerPhone;
  final String? ownerImage;
  final String? ownerId;
  final String propertyId;
  final String propertyTitle;
  final String propertyAddress;
  final double propertyPrice;

  const ClientOwnerSection({
    super.key,
    this.ownerName,
    this.ownerPhone,
    this.ownerImage,
    this.ownerId,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyAddress,
    required this.propertyPrice,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = (ownerName != null && ownerName!.trim().isNotEmpty)
        ? ownerName!
        : 'مالك العقار';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.person_pin_circle_rounded,
                    color: AppColors.primaryGreen,
                    size: 22,
                  ),
                  Gap(8),
                  Text(
                    'معلومات مالك العقار',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: AppColors.primaryGreen,
                    ),
                    Gap(4),
                    Text(
                      'مالك موثق',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          // Owner Info Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: (ownerImage != null && ownerImage!.trim().isNotEmpty)
                        ? Image.network(
                            ownerImage!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildAvatarFallback(),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                              );
                            },
                          )
                        : _buildAvatarFallback(),
                  ),
                ),
                const Gap(14),
                // Name and Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Gap(6),
                          const Text(
                            'متاح للرد على الاستفسارات',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(14),
          // Contact Buttons Row (UI only)
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final conversation = await ChatService().openConversation(
                        ownerId: ownerId ?? '',
                        ownerName: ownerName ?? '',
                        ownerImage: ownerImage ?? '',
                        propertyId: propertyId,
                        propertyTitle: propertyTitle,
                        propertyAddress: propertyAddress,
                        propertyPrice: propertyPrice,
                      );
                      if (context.mounted) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (sheetContext) {
                            return DraggableScrollableSheet(
                              initialChildSize: 0.92,
                              minChildSize: 0.7,
                              maxChildSize: 0.96,
                              expand: false,
                              builder: (sheetContext, scrollController) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightBg,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(22),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(22),
                                    ),
                                    child: ChatRoomPageBody(
                                      conversation: conversation,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              error.toString().replaceFirst('Bad state: ', ''),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                  label: const Text(
                    'تواصل مع صاحب العقار',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Gap(10),
              // Call Button UI
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.phone_in_talk_rounded,
                    color: AppColors.primaryGreen,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ownerPhone != null && ownerPhone!.isNotEmpty
                              ? 'رقم الهاتف: $ownerPhone'
                              : 'الاتصال بالمالك متاح قريباً',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: AppColors.primaryGreen,
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      color: AppColors.primaryGreen.withValues(alpha: 0.12),
      child: const Icon(
        Icons.person_rounded,
        color: AppColors.primaryGreen,
        size: 28,
      ),
    );
  }
}
