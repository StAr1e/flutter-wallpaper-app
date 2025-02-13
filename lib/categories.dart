import 'package:flutter/material.dart';
import 'category_details_screen.dart';

class CategoryItem {
  final String title;
  final String previewImage;
  final List<String> imagePaths;

  CategoryItem(this.title, this.previewImage, this.imagePaths);
}

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<CategoryItem> categories = [
    CategoryItem(
      "NATURE",
      'assets/images/Nature/n1.jpg',
      [
        'assets/images/Nature/n1.jpg',
        'assets/images/Nature/n2.jpg',
        'assets/images/Nature/n3.jpg',
        'assets/images/Nature/n4.jpg',
        'assets/images/Nature/n5.jpg',
        'assets/images/Nature/n6.jpg',
        'assets/images/Nature/n7.jpg',
        'assets/images/Nature/n8.jpg',
        'assets/images/Nature/n9.jpg',
        'assets/images/Nature/n10.jpg',
      ],
    ),
    CategoryItem(
      "PORTRAIT",
      'assets/images/Portrait/p1.jpg',
      [
        'assets/images/Portrait/p1.jpg',
        'assets/images/Portrait/p2.jpg',
        'assets/images/Portrait/p3.jpg',
        'assets/images/Portrait/p4.jpg',
        'assets/images/Portrait/p5.jpg',
        'assets/images/Portrait/p6.jpg',
        'assets/images/Portrait/p7.jpg',
        'assets/images/Portrait/p8.jpg',
        'assets/images/Portrait/p9.jpg',
        'assets/images/Portrait/p10.jpg',
      ],
    ),
    CategoryItem(
      "BEACH\nMOUNTAIN",
      'assets/images/Beach/b1.jpg',
      [
        'assets/images/Beach/b1.jpg',
        'assets/images/Beach/b2.jpg',
        'assets/images/Beach/b3.jpg',
        'assets/images/Beach/b4.jpg',
        'assets/images/Beach/b5.jpg',
        'assets/images/Beach/b6.jpg',
        'assets/images/Beach/b7.jpg',
        'assets/images/Beach/b8.jpg',
        'assets/images/Beach/b9.jpg',
        'assets/images/Beach/b10.jpg',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories',
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: categories[index]);
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToCategoryDetails(context),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                category.previewImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black.withOpacity(0.35),
                ),
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategoryDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailsScreen(category: category),
      ),
    );
  }
}
