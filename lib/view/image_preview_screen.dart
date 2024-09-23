import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_task/const/colors.dart';
import 'package:get/get.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;
  const ImagePreviewScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _buildImageView(size),
          Container(
            height: size.height / 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          _buildCloseView(size, context)
        ],
      ),
    );
  }

  // Close Icon
  Widget _buildCloseView(Size size, BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04, vertical: size.height * 0.04),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: CircleAvatar(
              radius: size.height * 0.02,
              backgroundColor: Appcolor.whiteColor.withOpacity(0.3),
              child: Icon(
                Icons.close,
                size: size.height * 0.02,
                color: Appcolor.whiteColor,
              ),
            )),
      ),
    );
  }

  // Image View
  Widget _buildImageView(Size size) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
