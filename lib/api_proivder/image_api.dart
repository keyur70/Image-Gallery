import 'package:gallery_task/const/apiurl.dart';
import 'package:gallery_task/model/custom_response_model.dart';
import 'package:gallery_task/model/image_list_model.dart';
import 'package:http/http.dart' as http;

abstract class ApiProivder {
  // Get Image List Api
  static Future<CustomReponseModel<GetImageListModel>> getImageListApi(
      {required int pageNo, required String category}) async {
    final response = await http.get(
        Uri.parse("${ApiUrl.getbaseUrl}?key=${ApiUrl.key}&category=$category"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        });
    if (response.statusCode == 200) {
      return CustomReponseModel(
        status: 200,
        data: getImageListModelFromJson(response.body),
      );
    } else {
      return CustomReponseModel(status: 400);
    }
  }

  // Search Image List Api
  static Future<CustomReponseModel<GetImageListModel>> searchImageApi(
      String searchText) async {
    var url =
        '${ApiUrl.getbaseUrl}?key=${ApiUrl.key}&q=$searchText&image_type=photo&pretty=true&per_page=40';
    final response = await http.get(Uri.parse(url), headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": 'true',
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });
    if (response.statusCode == 200) {
      return CustomReponseModel(
        status: 200,
        data: getImageListModelFromJson(response.body),
      );
    } else {
      return CustomReponseModel(status: 400);
    }
  }
}
