class ResponseModel {
  int status;
  String message;
  dynamic data;
  bool rel;

  ResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.rel,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> item) {
    return ResponseModel(
        status: item['status'] ?? 0,
        message: item['message'] ?? '',
        data: item['data'] ?? '',
        rel: item['rel'] ?? false);
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
        "rel": rel,
      };
}
