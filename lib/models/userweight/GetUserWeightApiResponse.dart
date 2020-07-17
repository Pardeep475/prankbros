class GetUserWeightApiResponse {
  List<UserProfileWeights> userProfileWeights;
  String message;
  int status;

  GetUserWeightApiResponse(
      {this.userProfileWeights, this.message, this.status});

  GetUserWeightApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['userProfileWeights'] != null) {
      userProfileWeights = new List<UserProfileWeights>();
      json['userProfileWeights'].forEach((v) {
        userProfileWeights.add(new UserProfileWeights.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfileWeights != null) {
      data['userProfileWeights'] =
          this.userProfileWeights.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class UserProfileWeights {
  String weight;
  String createdOnStr;
  int id;
  String createdOn;
  int userId;

  UserProfileWeights(
      {this.weight, this.createdOnStr, this.id, this.createdOn, this.userId});

  UserProfileWeights.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    createdOnStr = json['createdOnStr'];
    id = json['id'];
    createdOn = json['createdOn'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['createdOnStr'] = this.createdOnStr;
    data['id'] = this.id;
    data['createdOn'] = this.createdOn;
    data['userId'] = this.userId;
    return data;
  }
}