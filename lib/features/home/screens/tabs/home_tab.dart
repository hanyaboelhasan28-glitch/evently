import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/firebase/firebase_utils.dart';
import '../../models/event.dart';
import 'home_tab/widgets/event_card_widget.dart';
import 'home_tab/widgets/home_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          HomeHeader(
            selectedCategory: selectedCategory,
            onCategoryChanged: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Event>>(
              stream: FirebaseUtils.getEventsStream(selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                var events = snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
                if (events.isEmpty) {
                  return const Center(child: Text('No Events Found'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventCardWidget(
                      eventId: events[index].id,
                      category: events[index].category,
                      title: events[index].title,
                      date: _formatDate(events[index].dateTime),
                      imagePath: _getCategoryImage(events[index].category),
                      isFavorite: events[index].isFavorite,
                    );
                  },
                );
              },
            ),
          ),
        ],
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
