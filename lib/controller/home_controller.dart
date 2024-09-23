import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gallery_task/api_proivder/image_api.dart';
import 'package:gallery_task/const/list.dart';
import 'package:gallery_task/model/custom_response_model.dart';
import 'package:gallery_task/model/image_list_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //-------------- Variables ----------------------//
  var isLoading = true.obs;
  var isLoadMore = true.obs;
  var getImageList = CustomReponseModel<GetImageListModel>().obs;
  ScrollController scrollController = ScrollController();
  int pageNo = 1;

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = ScrollController()..addListener(scrollListener);
    getImageListController(1);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    super.onClose();
  }

  // Get Image List Controller
  Future<CustomReponseModel<GetImageListModel>> getImageListController(
      int pageNo) async {
    try {
      isLoading(true);
      CustomReponseModel<GetImageListModel> getImageListRes =
          await ApiProivder.getImageListApi(pageNo: pageNo, category: '');
      if (getImageListRes.data != null) {
        getImageList.value = getImageListRes;
        return getImageListRes;
      }
    } finally {
      isLoading(false);
      return CustomReponseModel(status: 400);
    }
  }

  // Search Image List Controller
  Future<CustomReponseModel<GetImageListModel>> searchImageListController(
      String searchText) async {
    getImageList.value = await ApiProivder.searchImageApi(searchText);
    return getImageList.value;
  }

  //
  void scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadMore.value = true;

      int randomIndex = Random().nextInt(ConstList.categoryList.length);
      print(ConstList.categoryList[randomIndex]);
      pageNo = pageNo + 1;
      CustomReponseModel<GetImageListModel> getImage =
          await ApiProivder.getImageListApi(
              pageNo: pageNo, category: ConstList.categoryList[randomIndex]);
      getImageList.value.data?.hits.addAll(getImage.data?.hits ?? []);
      isLoadMore.value = false;
    }
  }
}
