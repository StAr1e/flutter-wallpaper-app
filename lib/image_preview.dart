import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:animate_do/animate_do.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  Color _backgroundColor = Colors.black;
  Color _buttonColor = Colors.white;
  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    _updateBackgroundColor();
  }

  Future<void> _updateBackgroundColor() async {
    final PaletteGenerator paletteGenerator;
    if (widget.imagePath.startsWith('assets/')) {
      final ByteData data = await rootBundle.load(widget.imagePath);
      final Uint8List bytes = data.buffer.asUint8List();
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        MemoryImage(bytes),
      );
    } else {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        FileImage(File(widget.imagePath)),
      );
    }

    if (!mounted) return; // Prevent state updates if widget is disposed
    setState(() {
      _backgroundColor = paletteGenerator.dominantColor?.color ?? Colors.black;
      _buttonColor = paletteGenerator.dominantColor?.color.withOpacity(0.8) ??
          Colors.white.withOpacity(0.8);
    });
  }

  /// Sets the wallpaper for Home or Lock screen
  Future<void> _setWallpaper(int location) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${widget.imagePath.split('/').last}';
      final ByteData data = await rootBundle.load(widget.imagePath);
      final List<int> bytes = data.buffer.asUint8List();
      final File file = File(filePath);
      await file.writeAsBytes(bytes);

      /// Set wallpaper
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper set successfully!')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to set wallpaper: $e')),
      );
    }
  }

  /// Saves the image to the gallery
  Future<void> _saveImageToGallery() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${widget.imagePath.split('/').last}';
      final ByteData data = await rootBundle.load(widget.imagePath);
      final List<int> bytes = data.buffer.asUint8List();
      final File file = File(filePath);
      await file.writeAsBytes(bytes);

      /// Save to gallery
      await GallerySaver.saveImage(file.path);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved to gallery!')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Base design size for scaling
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Hero(
                tag: widget.imagePath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    widget.imagePath,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover, // Ensures image fills the screen
                  ),
                ),
              ),
              Positioned(
                top: 40.h,
                left: 10.w,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 30.sp),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                bottom: 50.h,
                left: 20.w,
                right: 20.w,
                child: Column(
                  children: [
                    FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _buttonColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                        onPressed: () {
                          setState(() {
                            _showOptions = !_showOptions;
                          });
                        },
                        child: Text("Set as Wallpaper",
                            style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                    if (_showOptions)
                      FadeInUp(
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          children: [
                            _actionButton(
                                Icons.home,
                                "Set as Home Screen",
                                () => _setWallpaper(
                                    WallpaperManager.HOME_SCREEN)),
                            _actionButton(
                                Icons.lock,
                                "Set as Lock Screen",
                                () => _setWallpaper(
                                    WallpaperManager.LOCK_SCREEN)),
                            _actionButton(
                                Icons.download, "Save", _saveImageToGallery),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: FadeInLeft(
        duration: Duration(milliseconds: 500),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: _buttonColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
          ),
          icon: Icon(icon, size: 22.sp),
          label: Text(label, style: TextStyle(fontSize: 14.sp)),
          onPressed: onTap,
        ),
      ),
    );
  }
}
