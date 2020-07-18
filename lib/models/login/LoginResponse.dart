class LoginResponse {
  String message;
  UserDetails userDetails;
  int status;

  LoginResponse({this.message, this.userDetails, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class UserDetails {
  String firstName;
  String lastName;
  int influencerId;
  String password;
  bool deleted;
  String language;
  int trainingWeek;
  int id;
  String accessToken;
  String createdOn;
  String email;
  String status;

  UserDetails(
      {this.firstName,
        this.lastName,
        this.influencerId,
        this.password,
        this.deleted,
        this.language,
        this.trainingWeek,
        this.id,
        this.accessToken,
        this.createdOn,
        this.email,
        this.status});

  UserDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    influencerId = json['influencerId'];
    password = json['password'];
    deleted = json['deleted'];
    language = json['language'];
    trainingWeek = json['trainingWeek'];
    id = json['id'];
    accessToken = json['accessToken'];
    createdOn = json['createdOn'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['influencerId'] = this.influencerId;
    data['password'] = this.password;
    data['deleted'] = this.deleted;
    data['language'] = this.language;
    data['trainingWeek'] = this.trainingWeek;
    data['id'] = this.id;
    data['accessToken'] = this.accessToken;
    data['createdOn'] = this.createdOn;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}