import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ScreenUtilInit(
      designSize: const Size(360, 690), // Base design reference
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "About Us",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Name
                Text(
                  'BALOCHIFY',
                  style: GoogleFonts.poppins(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 12.h),

                // App Description (Adapts to dark mode)
                Text(
                  "Balochify Wallpapers offers high-quality wallpapers curated to personalize your device. All images are inspired by the beauty of Balochistan.Inaddition this app include limited images, but we will update it regularly.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                SizedBox(height: 20.h),

                // Developer Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Text(
                          "Developer Info",
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),

                        // Developer Image
                        CircleAvatar(
                          radius: 50.r,
                          backgroundImage: const AssetImage(
                              'assets/images/icons/devlogo.jpg'),
                        ),
                        SizedBox(height: 10.h),

                        // Developer Name
                        Text(
                          "Developed by Sayad Akbar",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 6.h),

                        // Developer Bio
                        Text(
                          "Passionate Flutter developer dedicated to building seamless app experiences.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // GitHub Button with Logo
                        ElevatedButton.icon(
                          onPressed: () =>
                              _launchURL('https://github.com/StAr1e'),
                          icon: Image.asset(
                            'assets/images/icons/glogo.png', // GitHub Logo
                            width: 24.w,
                            height: 24.h,
                          ),
                          label: const Text("GitHub Profile"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Instagram Contributors
                Text(
                  "Contributors",
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton("Najeeb Akhtar",
                        'https://www.instagram.com/najeebakthar', isDarkMode),
                    SizedBox(width: 16.w),
                    _buildSocialButton(
                        "Israr Shoukat",
                        'https://www.instagram.com/israr_shoukat_/',
                        isDarkMode),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(String name, String url, bool isDarkMode) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Image.asset(
            'assets/images/icons/instagram.png',
            width: 30.w,
            height: 30.h,
          ),
          SizedBox(height: 6.h),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white70 : Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
