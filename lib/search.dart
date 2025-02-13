import 'package:flutter/material.dart';
import 'image_preview.dart';

class SearchScreen extends StatefulWidget {
  final Map<String, List<String>> categoryImages;

  const SearchScreen({super.key, required this.categoryImages});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<String> searchResults = [];

  void searchWallpapers(String text) {
    setState(() {
      if (text.isEmpty) {
        searchResults = [];
        return;
      }

      searchResults = widget.categoryImages.entries
          .where(
              (entry) => entry.key.toLowerCase().contains(text.toLowerCase()))
          .expand((entry) => entry.value)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search wallpapers...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            query = value;
            searchWallpapers(query); // Call search function on text change
          },
          onSubmitted: searchWallpapers, // Call search function on submit
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Trigger the search using the current query
              searchWallpapers(query);
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

          return searchResults.isEmpty
              ? Center(child: Text('No Results'))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  padding: EdgeInsets.all(8),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to preview screen on image tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePreviewScreen(
                                imagePath: searchResults[index]),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          searchResults[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
