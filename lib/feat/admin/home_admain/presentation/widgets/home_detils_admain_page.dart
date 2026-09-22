import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/home_admain/domain/entity/entuty_cart_home_admin_model.dart';
import 'package:sacny/feat/admin/home_admain/presentation/models/admin_tenant_preview.dart';
import 'package:sacny/feat/admin/home_admain/presentation/widgets/admin_apartment_details_header.dart';
import 'package:sacny/feat/admin/home_admain/presentation/widgets/admin_overdue_months_section.dart';
import 'package:sacny/feat/admin/home_admain/presentation/widgets/admin_tenants_section.dart';

class HomeDetilsAdmainPageBody extends StatefulWidget {
  const HomeDetilsAdmainPageBody({super.key, required this.property});

  final EntutyCartHomeAdminModel property;

  @override
  State<HomeDetilsAdmainPageBody> createState() =>
      _HomeDetilsAdmainPageBodyState();
}

class _HomeDetilsAdmainPageBodyState extends State<HomeDetilsAdmainPageBody> {
  final List<String> _overdueMonths = [];
  final List<AdminTenantPreview> _tenants = [];
  late int _occupiedBeds;

  @override
  void initState() {
    super.initState();
    _occupiedBeds = widget.property.occupiedBeds;
  }

  int get _availableBeds => (widget.property.totalBeds - _occupiedBeds).clamp(
    0,
    widget.property.totalBeds,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        title: const Text(
          'تفاصيل الشقة',
          textDirection: TextDirection.rtl,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
        child: Column(
          children: [
            AdminApartmentDetailsHeader(
              title: widget.property.title,
              price: widget.property.price,
              totalBeds: widget.property.totalBeds,
              availableBeds: _availableBeds,
            ),
            const SizedBox(height: 14),
            if (_overdueMonths.isNotEmpty)
              AdminOverdueMonthsSection(months: _overdueMonths),
            if (_overdueMonths.isNotEmpty) const SizedBox(height: 14),
            AdminTenantsSection(
              tenants: _tenants,
              onAddTenant: _showAddTenantDialog,
              onRemoveTenant: _confirmRemoveTenant,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddTenantDialog() async {
    if (_availableBeds <= 0) {
      _showMessage('لا توجد أسرة متاحة لإضافة مستأجر');
      return;
    }

    final tenant = await showDialog<AdminTenantPreview>(
      context: context,
      builder: (context) => _AddTenantDialog(bedNumber: _tenants.length + 1),
    );

    if (tenant != null && mounted) {
      await FirebaseFirestore.instance.collection('property').doc(widget.property.id).update({
        'occupiedBeds': FieldValue.increment(1),
        'availableBeds': _availableBeds - 1,
        'status': _availableBeds - 1 > 0 ? 'available' : 'full',
      });
      setState(() {
        _occupiedBeds++;
        _tenants.add(tenant);
      });
    }
  }

  Future<void> _confirmRemoveTenant(AdminTenantPreview tenant) async {
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المستأجر', textDirection: TextDirection.rtl),
        content: Text(
          'هل تريد حذف ${tenant.name} من الشقة؟',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (shouldRemove == true && mounted) {
      await FirebaseFirestore.instance.collection('property').doc(widget.property.id).update({
        'occupiedBeds': FieldValue.increment(-1),
        'availableBeds': _availableBeds + 1,
        'status': 'available',
      });
      setState(() {
        _occupiedBeds--;
        _tenants.remove(tenant);
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, textDirection: TextDirection.rtl)),
    );
  }
}

class _AddTenantDialog extends StatefulWidget {
  const _AddTenantDialog({required this.bedNumber});

  final int bedNumber;

  @override
  State<_AddTenantDialog> createState() => _AddTenantDialogState();
}

class _AddTenantDialogState extends State<_AddTenantDialog> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة مستأجر', textDirection: TextDirection.rtl),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            textDirection: TextDirection.rtl,
            decoration: const InputDecoration(labelText: 'اسم المستأجر'),
          ),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'رقم الهاتف'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          onPressed: () {
            final name = nameController.text.trim();
            final phone = phoneController.text.trim();
            if (name.isEmpty || phone.isEmpty) return;
            Navigator.pop(
              context,
              AdminTenantPreview(
                name: name,
                phone: phone,
                room: 'سرير ${widget.bedNumber}',
              ),
            );
          },
          child: const Text('إضافة'),
        ),
      ],
    );
  }
}
