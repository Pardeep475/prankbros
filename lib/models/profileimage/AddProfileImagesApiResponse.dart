class AddProfileImagesApiResponse {
  String imagePath;
  String message;
  int status;

  AddProfileImagesApiResponse({this.imagePath, this.message, this.status});

  AddProfileImagesApiResponse.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}