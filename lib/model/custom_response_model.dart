class CustomReponseModel<T> {
  int? status;
  String? message;
  T? data;

  CustomReponseModel({this.status, this.message, this.data});
}
