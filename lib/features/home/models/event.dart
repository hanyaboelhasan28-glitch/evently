import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'events';
  String id;
  String title;
  String description;
  String image;
  String category;
  DateTime dateTime;
  bool isFavorite;

  Event({
    this.id = '',
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.dateTime,
    this.isFavorite = false,
  });

  Event.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          image: json['image'] as String,
          category: json['category'] as String,
          dateTime: (json['dateTime'] as Timestamp).toDate(),
          isFavorite: json['isFavorite'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'category': category,
      'dateTime': Timestamp.fromDate(dateTime),
      'isFavorite': isFavorite,
    };
  }
}
