import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';

class NearbyUniversitiesSelector extends StatefulWidget {
  final ValueChanged<List<String>>? onUniversitiesChanged;

  const NearbyUniversitiesSelector({
    super.key,
    this.onUniversitiesChanged,
  });

  @override
  State<NearbyUniversitiesSelector> createState() =>
      _NearbyUniversitiesSelectorState();
}

class _NearbyUniversitiesSelectorState
    extends State<NearbyUniversitiesSelector> {
  final List<String> _selectedUniversities = [];

  // Popular Egyptian universities for fast selection / autocomplete
  static const List<String> _allUniversities = [
    'جامعة القاهرة',
    'جامعة عين شمس',
    'جامعة حلوان',
    'جامعة الأزهر',
    'الجامعة الأمريكية بالقاهرة (AUC)',
    'الجامعة الألمانية بالقاهرة (GUC)',
    'جامعة بدر (BUC)',
    'جامعة المستقبل (FUE)',
    'جامعة 6 أكتوبر',
    'جامعة مصر للعلوم والتكنولوجيا (MUST)',
    'جامعة المنصورة',
    'جامعة الإسكندرية',
    'جامعة بنها',
    'جامعة المنوفية',
    'جامعة الزقازيق',
    'جامعة طنطا',
    'جامعة النيل',
    'الأكاديمية العربية للعلوم والتكنولوجيا',
  ];

  TextEditingController? _textEditingController;

  void _addUniversity(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;

    if (_selectedUniversities.contains(trimmed)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تمت إضافة هذه الجامعة بالفعل'),
          duration: Duration(seconds: 2),
        ),
      );
      _textEditingController?.clear();
      return;
    }

    setState(() {
      _selectedUniversities.add(trimmed);
    });
    widget.onUniversitiesChanged?.call(_selectedUniversities);

    _textEditingController?.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textEditingController?.clear();
    });
  }

  void _removeUniversity(String name) {
    setState(() {
      _selectedUniversities.remove(name);
    });
    widget.onUniversitiesChanged?.call(_selectedUniversities);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'الجامعات القريبة من الشقة',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Nearby Universities',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Gap(14),

        // Autocomplete & Custom Input Container
        Card(
          elevation: 1.5,
          shadowColor: AppColors.primaryGreen.withValues(alpha: 0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: AppColors.primaryGreen.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input row with Add button
                Row(
                  children: [
                    // Text Field with suggestions
                    Expanded(
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return _allUniversities.where((String option) {
                            return option.contains(textEditingValue.text) &&
                                !_selectedUniversities.contains(option);
                          });
                        },
                        onSelected: (String selection) {
                          _addUniversity(selection);
                        },
                        optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options,
                        ) {
                          return Align(
                            alignment: Alignment.topRight,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              child: Container(
                                width: 280,
                                constraints:
                                    const BoxConstraints(maxHeight: 200),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 1),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final String option =
                                        options.elementAt(index);
                                    return ListTile(
                                      dense: true,
                                      leading: const Icon(
                                        Icons.school,
                                        size: 18,
                                        color: AppColors.primaryGreen,
                                      ),
                                      title: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      onTap: () {
                                        onSelected(option);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          _textEditingController = fieldTextEditingController;
                          return TextField(
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintText:
                                  'اكتب اسم أي جامعة أو اختر من المقترحات...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                Icons.school_outlined,
                                color: AppColors.primaryGreen,
                                size: 22,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColors.primaryGreen,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            onSubmitted: (value) {
                              _addUniversity(value);
                            },
                          );
                        },
                      ),
                    ),
                    const Gap(8),

                    // Add Button
                    ElevatedButton(
                      onPressed: () {
                        final text = _textEditingController?.text ?? '';
                        if (text.trim().isNotEmpty) {
                          _addUniversity(text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'إضافة +',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Selected Universities Chips
                if (_selectedUniversities.isNotEmpty) ...[
                  const Gap(12),
                  const Text(
                    'الجامعات المختارة:',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedUniversities.map((uni) {
                      return Chip(
                        label: Text(
                          uni,
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        avatar: const Icon(
                          Icons.school,
                          size: 16,
                          color: AppColors.primaryGreen,
                        ),
                        backgroundColor:
                            AppColors.primaryGreen.withValues(alpha: 0.08),
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 15,
                          color: Colors.redAccent,
                        ),
                        onDeleted: () => _removeUniversity(uni),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: AppColors.primaryGreen.withValues(alpha: 0.3),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                // Quick Suggestion Chips (popular ones not yet selected)
                const Gap(14),
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 15,
                      color: Colors.amber.shade700,
                    ),
                    const Gap(6),
                    Text(
                      'جامعات مقترحة سريعة (اضغط للإضافة مباشرة):',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                SizedBox(
                  height: 34,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _allUniversities
                        .where((u) => !_selectedUniversities.contains(u))
                        .length,
                    separatorBuilder: (context, index) => const Gap(8),
                    itemBuilder: (context, index) {
                      final available = _allUniversities
                          .where((u) => !_selectedUniversities.contains(u))
                          .toList();
                      final uni = available[index];
                      return ActionChip(
                        label: Text(
                          uni,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        avatar: const Icon(
                          Icons.add,
                          size: 13,
                          color: AppColors.primaryGreen,
                        ),
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        onPressed: () => _addUniversity(uni),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
