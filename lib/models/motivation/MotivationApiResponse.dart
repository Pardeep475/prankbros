class MotivationApiResponse {
  MotivationData motivationData;
  String message;
  int status;

  MotivationApiResponse({this.motivationData, this.message, this.status});

  MotivationApiResponse.fromJson(Map<String, dynamic> json) {
    motivationData = json['motivationData'] != null
        ? new MotivationData.fromJson(json['motivationData'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.motivationData != null) {
      data['motivationData'] = this.motivationData.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class MotivationData {
  int week;
  String imagePath1;
  String videoPath1;
  String imagePath2;
  String videoPath2;
  String imagePath3;
  String videoPath3;
  String imagePath4;
  String videoPath4;
  List<WorkoutActivities> workoutActivities;
  int workouts;

  int motivationalVideos;


  MotivationData({this.week, this.imagePath1, this.videoPath1, this.imagePath2,
    this.videoPath2, this.imagePath3, this.videoPath3, this.imagePath4,
    this.videoPath4, this.workoutActivities, this.workouts,
    this.motivationalVideos});

  MotivationData.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    imagePath1 = json['imagePath1'];
    videoPath1 = json['videoPath1'];
    if (json['workoutActivities'] != null) {
      workoutActivities = new List<WorkoutActivities>();
      json['workoutActivities'].forEach((v) {
        workoutActivities.add(new WorkoutActivities.fromJson(v));
      });
    }
    workouts = json['workouts'];
    imagePath2 = json['imagePath2'];
    videoPath2 = json['videoPath2'];
    imagePath3 = json['imagePath3'];
    videoPath3 = json['videoPath3'];
    imagePath4 = json['imagePath4'];
    videoPath4 = json['videoPath4'];
    motivationalVideos = json['motivationalVideos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    data['imagePath1'] = this.imagePath1;
    data['videoPath1'] = this.videoPath1;
    if (this.workoutActivities != null) {
      data['workoutActivities'] =
          this.workoutActivities.map((v) => v.toJson()).toList();
    }
    data['workouts'] = this.workouts;
    data['imagePath2'] = this.imagePath2;
    data['videoPath2'] = this.videoPath2;
    data['imagePath3'] = this.imagePath3;
    data['videoPath3'] = this.videoPath3;
    data['imagePath4'] = this.imagePath4;
    data['videoPath4'] = this.videoPath4;
    data['motivationalVideos'] = this.motivationalVideos;
    return data;
  }
}

class WorkoutActivities {
  String workoutName;
  String createdOnStr;

  WorkoutActivities({this.workoutName, this.createdOnStr});

  WorkoutActivities.fromJson(Map<String, dynamic> json) {
    workoutName = json['workoutName'];
    createdOnStr = json['createdOnStr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workoutName'] = this.workoutName;
    data['createdOnStr'] = this.createdOnStr;
    return data;
  }
}