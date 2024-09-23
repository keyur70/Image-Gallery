import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_task/const/colors.dart';
import 'package:gallery_task/const/strings.dart';
import 'package:gallery_task/controller/home_controller.dart';
import 'package:gallery_task/view/image_preview_screen.dart';
import 'package:gallery_task/view/widgets/image_card_view.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //-------------------------- Controller Instance ------------------------------------//
  HomeController homeController = Get.put(HomeController());
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Appcolor.whiteColor,
      appBar: _buildAppBar(),
      body: Obx(
        () {
          if (homeController.isLoading.value) {
            return const Center(child: CupertinoActivityIndicator());
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Column(
                children: [
                  _buildTextFiledView(size, context),
                  SizedBox(height: size.height * 0.02),
                  _buildImageList(context),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTextFiledView(Size size, BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onChanged: (value) async {
        await homeController.searchImageListController(value);
      },
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        fillColor: Appcolor.grey300,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: "Enter a query",
        suffixIcon: IconButton(
          onPressed: () async {
            await homeController.searchImageListController(_controller.text);
          },
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }

  //------------------------------------ UI Elements --------------------------------------//

  // Appbar View
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        ConstStrings.galleryStr,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }

// Image Gridview
  Widget _buildImageList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
            controller: homeController.scrollController,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).size.width ~/ 250).toInt(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.5),
            ),
            itemCount: homeController.isLoadMore.value
                ? (homeController.getImageList.value.data?.hits.length ?? 0 + 1)
                : homeController.getImageList.value.data?.hits.length,
            itemBuilder: (context, index) {
              if (index <
                  (homeController.getImageList.value.data?.hits.length ?? 0)) {
                final imageData =
                    homeController.getImageList.value.data?.hits[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => ImagePreviewScreen(
                        imageUrl: imageData?.largeImageUrl ?? '',
                      ),
                    );
                  },
                  child: ImageCardView(
                    imageData: imageData,
                  ),
                );
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            },
          );
        }),
      ),
    );
  }
}
