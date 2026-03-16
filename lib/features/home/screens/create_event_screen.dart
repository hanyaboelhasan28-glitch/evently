import 'package:flutter/material.dart';
import '../../../core/assets/app_strings.dart';
import '../../../core/firebase/firebase_utils.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../models/event.dart';
import 'widgets/create_event_category_selector.dart';
import 'widgets/create_event_date_time.dart';
import 'widgets/create_event_fields.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = 'create_event';
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedCategory = 'Sport';
  bool isLoading = false;

  final List<String> categories = [
    'Sport',
    'Birthday',
    'Meeting',
    'Exhibition',
    'Workshop'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(AppStrings.createEvent, style: AppStyles.titlePrimary),
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
                    onPressed: isLoading ? null : _addEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(AppStrings.addEvent,
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void _showTimePicker() async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  void _addEvent() async {
    if (_formKey.currentState?.validate() == true &&
        selectedDate != null &&
        selectedTime != null) {
      setState(() => isLoading = true);

      final dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final event = Event(
        title: titleController.text,
        description: descriptionController.text,
        image: 'assets/logo/$selectedCategory.png',
        category: selectedCategory,
        dateTime: dateTime,
      );

      try {
        await FirebaseUtils.addEventToFirestore(event);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Event Added Successfully')));
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
    } else if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select Date and Time')));
    }
  }
}
