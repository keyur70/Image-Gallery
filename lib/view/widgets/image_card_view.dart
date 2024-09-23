import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_task/const/colors.dart';
import 'package:gallery_task/model/image_list_model.dart';

class ImageCardView extends StatelessWidget {
  final Hit? imageData;
  const ImageCardView({super.key, required this.imageData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildImageView(size),
        _buildBlackShadowView(size),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.015),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImgBottomView(
                size: size,
                icon: Icons.remove_red_eye,
                value: imageData?.likes.toString() ?? '',
              ),
              _buildImgBottomView(
                size: size,
                icon: Icons.favorite,
                value: imageData?.views.toString() ?? '',
              ),
            ],
          ),
        )
      ],
    );
  }

  // Image bottom View
  Widget _buildImgBottomView(
      {required Size size, required IconData icon, required String value}) {
    return Row(
      children: [
        Icon(
          icon,
          size: size.height * 0.02,
          color: Appcolor.whiteColor,
        ),
        // SizedBox(width: size.width * 0.01),?
        Text(
          value,
          style: TextStyle(
            color: Appcolor.whiteColor,
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Black Shadow View
  Widget _buildBlackShadowView(Size size) {
    return Container(
      height: size.height / 4,
      width: size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        gradient: LinearGradient(
          end: Alignment(0.0, 0),
          begin: Alignment(0.0, 0.5),
          colors: <Color>[
            Appcolor.black00Color,
            Appcolor.black12Color,
          ],
        ),
      ),
    );
  }

  // Image View
  Widget _buildImageView(Size size) {
    return Container(
      height: size.height / 4,
      width: size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: imageData?.previewUrl ?? '',
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }
}
