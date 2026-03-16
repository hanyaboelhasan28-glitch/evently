import 'package:flutter/material.dart';
import '../../../../core/assets/app_strings.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CreateEventFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const CreateEventFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.eventTitle, style: AppStyles.bodyBlack),
        const SizedBox(height: 8),
        CustomTextField(
          controller: titleController,
          hintText: 'Event Title',
          prefixIcon: Icons.edit_note,
          validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
        ),
        const SizedBox(height: 16),
        const Text(AppStrings.eventDescription, style: AppStyles.bodyBlack),
        const SizedBox(height: 8),
        CustomTextField(
          controller: descriptionController,
          hintText: 'Event Description',
          validator: (value) => value == null || value.isEmpty ? 'Description is required' : null,
        ),
      ],
    );
  }
}
