import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;

class Food {
  final String name;
  final double calories;
  final String imageUrl;

  Food({required this.name, required this.calories, required this.imageUrl});
}

class FoodRepository {
  Future<List<Food>> loadFoods() async {
    final String jsonString = await rootBundle.loadString('assets/food_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    List<Food> foods = jsonData.map((data) {
      return Food(
        name: data['name'],
        calories: data['calories'].toDouble(),
        imageUrl: 'assets/images/${data['image_url']}', // Sesuaikan dengan struktur direktori Anda
      );
    }).toList();

    return foods;
  }
}