class AddUserWeightApiResponse {
  String weight;
  String message;
  int status;

  AddUserWeightApiResponse({this.weight, this.message, this.status});

  AddUserWeightApiResponse.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}