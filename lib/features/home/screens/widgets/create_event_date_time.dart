import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/theme/app_styles.dart';

class CreateEventDateTime extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final VoidCallback onChooseDate;
  final VoidCallback onChooseTime;

  const CreateEventDateTime({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onChooseDate,
    required this.onChooseTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(AppStrings.chooseDate, style: AppStyles.bodyBlack),
            TextButton(
              onPressed: onChooseDate,
              child: Text(
                selectedDate == null
                    ? 'Select Date'
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
                style: AppStyles.linkPrimary,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(AppStrings.chooseTime, style: AppStyles.bodyBlack),
            TextButton(
              onPressed: onChooseTime,
              child: Text(
                selectedTime == null ? 'Select Time' : selectedTime!.format(context),
                style: AppStyles.linkPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
