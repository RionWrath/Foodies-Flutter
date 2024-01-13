  import 'package:flutter/material.dart';
  import 'food_data.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  
  import 'firebase_options.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foodies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      );
    }
  }

  class HomeScreen extends StatelessWidget {
    final FoodRepository _foodRepository = FoodRepository();

    HomeScreen();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Foodies'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Ganti dengan fungsi tidak asinkron
                openSearchPage(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Halaman Beranda'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu Utama',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text('Jenis Makanan'),
                onTap: () {
                  // Tambahkan logika untuk navigasi ke daftar makanan
                  Navigator.pop(context); // Menutup drawer
                },
              ),
              // Tambahkan item menu lainnya sesuai kebutuhan
              ListTile(
                leading: Icon(Icons.wine_bar),
                title: Text('Jenis Minuman'),
                onTap: () {
                  // Tambahkan logika untuk navigasi ke daftar makanan
                  Navigator.pop(context); // Menutup drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Calorie Counter'),
                onTap: () {
                  // Tambahkan logika untuk navigasi ke daftar makanan
                  Navigator.pop(context); // Menutup drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: () {
                  // Tambahkan logika untuk navigasi ke daftar makanan
                  Navigator.pop(context); // Menutup drawer
                },
              ),
            ],
          ),
        ),
      );
    }



    // Fungsi asinkron untuk memuat dan menampilkan tampilan pencarian
  void openSearchPage(BuildContext context) async {
      List<Food> foods = await _foodRepository.loadFoods();
      showSearch(context: context, delegate: FoodSearchDelegate(foods));
    }
  }

  class FoodSearchDelegate extends SearchDelegate<String> {
    final List<Food> foods;

    FoodSearchDelegate(this.foods);

    @override
    List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ];
    }

    @override
    Widget buildLeading(BuildContext context) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }

    @override
    Widget buildResults(BuildContext context) {
      return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return GestureDetector(
            onTap: () {
              // Tambahkan logika saat item di-tap
              print('${food.name}');
            },
            child: ListTile(
              title: Text(food.name),
              leading: Image.asset(
                food.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              subtitle: Text('Calories: ${food.calories}'),
            ),
          );
        },
      );
    }

    @override
    Widget buildSuggestions(BuildContext context) {
      // Tampilkan saran saat pengguna mengetik
      return buildResults(context);
    }
  }
