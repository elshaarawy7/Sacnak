import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/home_admain/presentation/models/admin_tenant_preview.dart';

class AdminTenantsSection extends StatelessWidget {
  const AdminTenantsSection({
    super.key,
    required this.tenants,
    required this.onAddTenant,
    required this.onRemoveTenant,
  });

  final List<AdminTenantPreview> tenants;
  final VoidCallback onAddTenant;
  final ValueChanged<AdminTenantPreview> onRemoveTenant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkText.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.people_alt_outlined,
                color: AppColors.secondaryBlue,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'المستأجرون',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: onAddTenant,
                tooltip: 'إضافة مستأجر',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: AppColors.white,
                ),
                icon: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (tenants.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'لا يوجد مستأجرون حاليًا',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            )
          else
            ...tenants.map(
              (tenant) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _TenantTile(
                  tenant: tenant,
                  onRemove: () => onRemoveTenant(tenant),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TenantTile extends StatelessWidget {
  const _TenantTile({required this.tenant, required this.onRemove});

  final AdminTenantPreview tenant;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.secondaryBlue.withValues(alpha: 0.12),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.secondaryBlue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tenant.name,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${tenant.phone} • ${tenant.room}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: AppColors.darkText.withValues(alpha: 0.58),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            tooltip: 'حذف المستأجر',
            icon: Icon(Icons.delete_outline, color: Colors.red.shade700),
          ),
        ],
      ),
    );
  }
}
