class GetProfileImagesApiResponse {
  List<UserProfileImages> userProfileImages;
  String message;
  int status;

  GetProfileImagesApiResponse(
      {this.userProfileImages, this.message, this.status});

  GetProfileImagesApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['userProfileImages'] != null) {
      userProfileImages = new List<UserProfileImages>();
      json['userProfileImages'].forEach((v) {
        userProfileImages.add(new UserProfileImages.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProfileImages != null) {
      data['userProfileImages'] =
          this.userProfileImages.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class UserProfileImages {
  String imagePath;
  String thumbnailPath;
  String createdOnStr;
  int id;
  String createdOn;
  int userId;

  UserProfileImages(
      {this.imagePath,
        this.thumbnailPath,
        this.createdOnStr,
        this.id,
        this.createdOn,
        this.userId});

  UserProfileImages.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    thumbnailPath = json['thumbnailPath'];
    createdOnStr = json['createdOnStr'];
    id = json['id'];
    createdOn = json['createdOn'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['thumbnailPath'] = this.thumbnailPath;
    data['createdOnStr'] = this.createdOnStr;
    data['id'] = this.id;
    data['createdOn'] = this.createdOn;
    data['userId'] = this.userId;
    return data;
  }
}