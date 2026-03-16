import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/firebase/firebase_utils.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/event.dart';
import 'home_tab/widgets/event_card_widget.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search for Event',
              hintStyle: const TextStyle(color: AppColors.primary),
              prefixIcon: const Icon(Icons.search, color: AppColors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Event>>(
        stream: FirebaseUtils.getFavoriteEventsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          var events = snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
          
          // Filtering based on search query
          var filteredEvents = events.where((event) => 
            event.title.toLowerCase().contains(searchQuery)
          ).toList();

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
                imagePath: _getCategoryImage(filteredEvents[index].category),
                isFavorite: filteredEvents[index].isFavorite,
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${dateTime.day} ${months[dateTime.month - 1]}';
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
