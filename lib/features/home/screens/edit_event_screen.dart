import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/assets/app_strings.dart';
import '../../../core/firebase/firebase_utils.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../models/event.dart';
import 'widgets/create_event_category_selector.dart';
import 'widgets/create_event_date_time.dart';
import 'widgets/create_event_fields.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = 'edit_event';
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late String selectedCategory;
  bool isLoading = false;
  bool isInitialized = false;

  final List<String> categories = [
    'Sport',
    'Birthday',
    'Meeting',
    'Exhibition',
    'Workshop'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final event = ModalRoute.of(context)!.settings.arguments as Event;
      titleController = TextEditingController(text: event.title);
      descriptionController = TextEditingController(text: event.description);
      selectedDate = event.dateTime;
      selectedTime = TimeOfDay.fromDateTime(event.dateTime);
      selectedCategory = event.category;
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(AppStrings.editEvent, style: AppStyles.titlePrimary),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Category', style: AppStyles.bodyBlack),
                const SizedBox(height: 10),
                CreateEventCategorySelector(
                  categories: categories,
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) {
                    setState(() => selectedCategory = category);
                  },
                ),
                const SizedBox(height: 24),
                CreateEventFields(
                  titleController: titleController,
                  descriptionController: descriptionController,
                ),
                const SizedBox(height: 24),
                CreateEventDateTime(
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                  onChooseDate: _showDatePicker,
                  onChooseTime: _showTimePicker,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _updateEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(AppStrings.updateEvent,
                            style: AppStyles.buttonWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void _showTimePicker() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  void _updateEvent() async {
    if (_formKey.currentState?.validate() == true &&
        selectedDate != null &&
        selectedTime != null) {
      setState(() => isLoading = true);

      final eventArgs = ModalRoute.of(context)!.settings.arguments as Event;

      final dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final updatedEvent = Event(
        id: eventArgs.id,
        title: titleController.text,
        description: descriptionController.text,
        image: 'assets/logo/$selectedCategory.png',
        category: selectedCategory,
        dateTime: dateTime,
        isFavorite: eventArgs.isFavorite,
      );

      try {
        await FirebaseUtils.updateEventInFirestore(updatedEvent);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event Updated Successfully')));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }
}
