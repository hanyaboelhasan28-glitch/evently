import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/firebase/firebase_utils.dart';
import '../../../../models/event.dart';
import '../../../tabs/home_tab/widgets/event_card_widget.dart';

class FavoriteEventsList extends StatelessWidget {
  final String searchQuery;

  const FavoriteEventsList({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Event>>(
      stream: FirebaseUtils.getFavoriteEventsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        
        var events = snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];

        var filteredEvents = events
            .where((event) => event.title.toLowerCase().contains(searchQuery))
            .toList();

        if (filteredEvents.isEmpty) {
          return const Center(child: Text('No Favorite Events Found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            return EventCardWidget(
              eventId: filteredEvents[index].id,
              category: filteredEvents[index].category,
              title: filteredEvents[index].title,
              date: _formatDate(filteredEvents[index].dateTime),
              imagePath: filteredEvents[index].image,
              isFavorite: filteredEvents[index].isFavorite,
              event: filteredEvents[index],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]}';
  }
}
