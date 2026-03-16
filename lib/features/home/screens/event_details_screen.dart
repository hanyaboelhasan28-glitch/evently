import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/assets/app_strings.dart';
import '../../../core/firebase/firebase_utils.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../models/event.dart';
import 'edit_event_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = 'event_details';

  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(AppStrings.eventDetails, style: AppStyles.titlePrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primary),
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditEventScreen.routeName,
                arguments: event,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.red),
            onPressed: () => _showDeleteDialog(context, event.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  _getCategoryImage(event.category),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 100, color: AppColors.primary),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: AppStyles.titlePrimary),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.calendar_month, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd MMMM yyyy').format(event.dateTime),
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(event.dateTime),
                              style: const TextStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Description', style: AppStyles.bodyBlack),
                  const SizedBox(height: 8),
                  Text(event.description, style: AppStyles.bodyBlack),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String eventId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure you want to delete this event?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseUtils.deleteEventFromFirestore(eventId);
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to Home
              }
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
    );
  }

  String _getCategoryImage(String category) {
    switch (category) {
      case 'Sport': return 'assets/logo/Sport.png';
      case 'Birthday': return 'assets/logo/Birthday.png';
      case 'Meeting': return 'assets/logo/Meeting.png';
      default: return 'assets/logo/Exhibition.png';
    }
  }
}
