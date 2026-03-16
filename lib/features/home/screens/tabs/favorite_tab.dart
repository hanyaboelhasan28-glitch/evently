import 'package:flutter/material.dart';
import 'favorite_tab/widgets/favorite_events_list.dart';
import 'favorite_tab/widgets/favorite_search_bar.dart';

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
        title: FavoriteSearchBar(
          onChanged: (value) {
            setState(() {
              searchQuery = value.toLowerCase();
            });
          },
        ),
      ),
      body: FavoriteEventsList(searchQuery: searchQuery),
    );
  }
}
