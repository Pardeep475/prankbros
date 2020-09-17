import 'package:prankbros2/models/workout/GetUserTrainingResponseApi.dart';

class WorkoutDetail2Models {
  String baseUrl;
  Trainings trainings;
  bool isHomeWorkout=false;
List<String> localPaths;
  WorkoutDetail2Models({this.baseUrl, this.trainings,this.isHomeWorkout,this.localPaths});

}
