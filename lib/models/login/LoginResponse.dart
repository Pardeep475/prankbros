class LoginResponse {
  int status;
  String message;
  UserData userDetails;

  LoginResponse(this.status, this.message, this.userDetails);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    print("***************json*******************");
    print("json" + json.toString());
    status = json['status'];
    print("status1" + status.toString());

    if (status == 0) {
      print("status2" + status.toString());
      userDetails = json['userDetails'] != null
          ? UserData.fromJson(json['userDetails'])
          : null;
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class UserData {
  String firstName;
  String lastName;
  String password;
  int id;
  String accessToken;
  String email;
  String status;

  UserData(
      {this.firstName,
      this.lastName,
      this.password,
      this.id,
      this.accessToken,
      this.email,
      this.status});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    accessToken = json['accessToken'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    data['accessToken'] = this.accessToken;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}
