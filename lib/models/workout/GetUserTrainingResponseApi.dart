class GetUserTrainingResponseApi {
  List<String> weekNameList;
  String awsEndpointUrl;
  List<Trainings> trainings;
  int trainingWeek;
  String message;
  int status;

  GetUserTrainingResponseApi(
      {this.weekNameList,
        this.awsEndpointUrl,
        this.trainings,
        this.trainingWeek,
        this.message,
        this.status});

  GetUserTrainingResponseApi.fromJson(Map<String, dynamic> json) {
    weekNameList = json['weekNameList'].cast<String>();
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
    data['weekNameList'] = this.weekNameList;
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

class Trainings {
  String trainingType;
  String descriptionEN;
  int influencerId;
  int week;
  String imagePath;
  String nameEN;
  String createdOn;
  String nameDE;
  bool deleted;
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
        this.createdOn,
        this.nameDE,
        this.deleted,
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
    nameEN = json['nameEN'];
    createdOn = json['createdOn'];
    nameDE = json['nameDE'];
    deleted = json['deleted'];
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
    data['nameDE'] = this.nameDE;
    data['deleted'] = this.deleted;
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
  int sets;
  int trainingId;
  String exerciseType;
  String imagePath;
  String workoutTime;
  String nameEN;
  String createdOn;
  int repetitions;
  String exerciseTime;
  String videoPath;
  String nameDE;
  String descriptionDE;
  int id;

  Exercises(
      {this.descriptionEN,
        this.sets,
        this.trainingId,
        this.exerciseType,
        this.imagePath,
        this.workoutTime,
        this.nameEN,
        this.createdOn,
        this.repetitions,
        this.exerciseTime,
        this.videoPath,
        this.nameDE,
        this.descriptionDE,
        this.id});

  Exercises.fromJson(Map<String, dynamic> json) {
    descriptionEN = json['descriptionEN'];
    sets = json['sets'];
    trainingId = json['trainingId'];
    exerciseType = json['exerciseType'];
    imagePath = json['imagePath'];
    workoutTime = json['workoutTime'];
    nameEN = json['nameEN'];
    createdOn = json['createdOn'];
    repetitions = json['repetitions'];
    exerciseTime = json['exerciseTime'];
    videoPath = json['videoPath'];
    nameDE = json['nameDE'];
    descriptionDE = json['descriptionDE'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descriptionEN'] = this.descriptionEN;
    data['sets'] = this.sets;
    data['trainingId'] = this.trainingId;
    data['exerciseType'] = this.exerciseType;
    data['imagePath'] = this.imagePath;
    data['workoutTime'] = this.workoutTime;
    data['nameEN'] = this.nameEN;
    data['createdOn'] = this.createdOn;
    data['repetitions'] = this.repetitions;
    data['exerciseTime'] = this.exerciseTime;
    data['videoPath'] = this.videoPath;
    data['nameDE'] = this.nameDE;
    data['descriptionDE'] = this.descriptionDE;
    data['id'] = this.id;
    return data;
  }
}