class PostTestResponseModel {
  int code;
  String message;
  int data;

  PostTestResponseModel(this.code, this.message, this.data);

  PostTestResponseModel.fromJson(Map<String, dynamic> map)
      : code = map["code"],
        message = map["message"],
        data = map["data"];
}
