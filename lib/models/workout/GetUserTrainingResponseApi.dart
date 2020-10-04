class GetUserTrainingResponseApi {
  List<WorkoutActivities> workoutActivities;
  String awsEndpointUrl;
  List<Trainings> trainings;
  int trainingWeek;
  String message;
  int status;

  GetUserTrainingResponseApi(
      {
        this.workoutActivities,
        this.awsEndpointUrl,
        this.trainings,
        this.trainingWeek,
        this.message,
        this.status});

  GetUserTrainingResponseApi.fromJson(Map<String, dynamic> json) {
    if (json['workoutActivities'] != null) {
      workoutActivities = new List<WorkoutActivities>();
      json['workoutActivities'].forEach((v) {
        workoutActivities.add(new WorkoutActivities.fromJson(v));
      });
    }
    awsEndpointUrl = json['awsEndpointUrl'];
    if (json['trainings'] != null) {
      trainings = new List<Trainings>();
      json['trainings'].forEach((v) {
        trainings.add(new Trainings.fromJson(v));
      });
    }
    trainingWeek = json['trainingWeek'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workoutActivities != null) {
      data['workoutActivities'] =
          this.workoutActivities.map((v) => v.toJson()).toList();
    }
    data['awsEndpointUrl'] = this.awsEndpointUrl;
    if (this.trainings != null) {
      data['trainings'] = this.trainings.map((v) => v.toJson()).toList();
    }
    data['trainingWeek'] = this.trainingWeek;
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

class Trainings {
  String trainingType;
  String descriptionEN;
  int influencerId;
  int week;
  String imagePath;
  String nameEN;
  String createdOn;
  String workoutTime;
  bool deleted;
  String nameDE;
  List<Exercises> exercises;
  int trainingNumber;
  String descriptionDE;
  int id;

  Trainings(
      {this.trainingType,
        this.descriptionEN,
        this.influencerId,
        this.week,
        this.imagePath,
        this.nameEN,
        this.workoutTime,
        this.createdOn,
        this.deleted,
        this.nameDE,
        this.exercises,
        this.trainingNumber,
        this.descriptionDE,
        this.id});

  Trainings.fromJson(Map<String, dynamic> json) {
    trainingType = json['trainingType'];
    descriptionEN = json['descriptionEN'];
    influencerId = json['influencerId'];
    week = json['week'];
    imagePath = json['imagePath'];
    workoutTime = json['workoutTime'];
    nameEN = json['nameEN'];
    createdOn = json['createdOn'];
    deleted = json['deleted'];
    nameDE = json['nameDE'];
    if (json['exercises'] != null) {
      exercises = new List<Exercises>();
      json['exercises'].forEach((v) {
        exercises.add(new Exercises.fromJson(v));
      });
    }
    trainingNumber = json['trainingNumber'];
    descriptionDE = json['descriptionDE'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trainingType'] = this.trainingType;
    data['descriptionEN'] = this.descriptionEN;
    data['influencerId'] = this.influencerId;
    data['week'] = this.week;
    data['imagePath'] = this.imagePath;
    data['nameEN'] = this.nameEN;
    data['createdOn'] = this.createdOn;
    data['deleted'] = this.deleted;
    data['nameDE'] = this.nameDE;
    if (this.exercises != null) {
      data['exercises'] = this.exercises.map((v) => v.toJson()).toList();
    }
    data['trainingNumber'] = this.trainingNumber;
    data['descriptionDE'] = this.descriptionDE;
    data['id'] = this.id;
    return data;
  }
}

class Exercises {
  String descriptionEN;
  int trainingId;
  int sets;
  String imagePath;
  String exerciseType;
  String workoutTime;
  String nameEN;
  String createdOn;
  int repetitions;
  String videoPath;
  String exerciseTime;
  String nameDE;
  String descriptionDE;
  int id;

  Exercises(
      {this.descriptionEN,
        this.trainingId,
        this.sets,
        this.imagePath,
        this.exerciseType,
        this.workoutTime,
        this.nameEN,
        this.createdOn,
        this.repetitions,
        this.videoPath,
        this.exerciseTime,
        this.nameDE,
        this.descriptionDE,
        this.id});

  Exercises.fromJson(Map<String, dynamic> json) {
    descriptionEN = json['descriptionEN'];
    trainingId = json['trainingId'];
    sets = json['sets'];
    imagePath = json['imagePath'];
    exerciseType = json['exerciseType'];
    workoutTime = json['workoutTime'];
    nameEN = json['nameEN'];
    createdOn = json['createdOn'];
    repetitions = json['repetitions'];
    videoPath = json['videoPath'];
    exerciseTime = json['exerciseTime'];
    nameDE = json['nameDE'];
    descriptionDE = json['descriptionDE'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descriptionEN'] = this.descriptionEN;
    data['trainingId'] = this.trainingId;
    data['sets'] = this.sets;
    data['imagePath'] = this.imagePath;
    data['exerciseType'] = this.exerciseType;
    data['workoutTime'] = this.workoutTime;
    data['nameEN'] = this.nameEN;
    data['createdOn'] = this.createdOn;
    data['repetitions'] = this.repetitions;
    data['videoPath'] = this.videoPath;
    data['exerciseTime'] = this.exerciseTime;
    data['nameDE'] = this.nameDE;
    data['descriptionDE'] = this.descriptionDE;
    data['id'] = this.id;
    return data;
  }
}