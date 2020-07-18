import 'package:prankbros2/models/login/LoginResponse.dart';

class UpdateProfileApiResponse {
  String emailUpdateMessage;
  String message;
  UserDetails userDetails;
  int status;

  UpdateProfileApiResponse(
      {this.emailUpdateMessage, this.message, this.userDetails, this.status});

  UpdateProfileApiResponse.fromJson(Map<String, dynamic> json) {
    emailUpdateMessage = json['emailUpdateMessage'];
    message = json['message'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailUpdateMessage'] = this.emailUpdateMessage;
    data['message'] = this.message;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}
