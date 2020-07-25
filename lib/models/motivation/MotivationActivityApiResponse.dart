class MotivationActivityApiResponse {
  List<WorkoutActivities> workoutActivities;
  String message;
  int status;

  MotivationActivityApiResponse(
      {this.workoutActivities, this.message, this.status});

  MotivationActivityApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['workoutActivities'] != null) {
      workoutActivities = new List<WorkoutActivities>();
      json['workoutActivities'].forEach((v) {
        workoutActivities.add(new WorkoutActivities.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workoutActivities != null) {
      data['workoutActivities'] =
          this.workoutActivities.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
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