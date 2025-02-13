import 'package:flutter/material.dart';
import 'categories.dart';
import 'image_preview.dart'; // Make sure this file exists for image preview
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'navbar.dart'; // Import NavBar
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, List<String>> categoryImages;

  const HomeScreen({super.key, required this.categoryImages});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> displayedImages = [];
  List<String> randomImages = [];
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _updateRandomImages();
  }

  void _updateRandomImages() {
    final allImages = widget.categoryImages.values.expand((x) => x).toList();
    final random = Random();
    randomImages = List.generate(
        10, (index) => allImages[random.nextInt(allImages.length)]);
    setState(() {});
  }

  void _navigateToImagePreview(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                'BALOCHIFY',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 18.sp,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search,
                      color: isDarkMode ? Colors.white : Colors.black,
                      size: 24.sp),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
              ],
            ),
            drawer: NavBar(),
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              items: <Widget>[
                Icon(Icons.home,
                    size: 30.sp,
                    color: isDarkMode ? Colors.lightBlue : Colors.black),
                Icon(Icons.category,
                    size: 30.sp,
                    color: isDarkMode ? Colors.lightBlue : Colors.black),
                Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    size: 30.sp,
                    color: isDarkMode ? Colors.lightBlue : Colors.black),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: isDarkMode ? Colors.black : Colors.blueAccent,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) {
                setState(() {
                  if (index == 2) {
                    isDarkMode = !isDarkMode;
                  } else {
                    _page = index;
                  }
                });
              },
            ),
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: _page == 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 8.w,
                        mainAxisSpacing: 8.h,
                        childAspectRatio: 1,
                      ),
                      padding: EdgeInsets.all(8.w),
                      itemCount: randomImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _navigateToImagePreview(randomImages[index]);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.asset(
                              randomImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    )
                  : CategoriesScreen(),
            ),
          ),
        );
      },
    );
  }
}
