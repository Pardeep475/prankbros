class NutritionsApiResponse {
  List<NutritionData> allNutritions;
  List<NutritionData> mixNutritions;
  List<NutritionData> vegNutritions;
  List<NutritionData> favoriteNutritions;
  String message;
  int status;

  NutritionsApiResponse(
      {this.allNutritions,
        this.mixNutritions,
        this.vegNutritions,
        this.favoriteNutritions,
        this.message,
        this.status});

  NutritionsApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['allNutritions'] != null) {
      allNutritions = new List<NutritionData>();
      json['allNutritions'].forEach((v) {
        allNutritions.add(new NutritionData.fromJson(v));
      });
    }
    if (json['mixNutritions'] != null) {
      mixNutritions = new List<NutritionData>();
      json['mixNutritions'].forEach((v) {
        mixNutritions.add(new NutritionData.fromJson(v));
      });
    }
    if (json['vegNutritions'] != null) {
      vegNutritions = new List<NutritionData>();
      json['vegNutritions'].forEach((v) {
        vegNutritions.add(new NutritionData.fromJson(v));
      });
    }
    if (json['favoriteNutritions'] != null) {
      favoriteNutritions = new List<NutritionData>();
      json['favoriteNutritions'].forEach((v) {
        favoriteNutritions.add(new NutritionData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allNutritions != null) {
      data['allNutritions'] =
          this.allNutritions.map((v) => v.toJson()).toList();
    }
    if (this.mixNutritions != null) {
      data['mixNutritions'] =
          this.mixNutritions.map((v) => v.toJson()).toList();
    }
    if (this.vegNutritions != null) {
      data['vegNutritions'] =
          this.vegNutritions.map((v) => v.toJson()).toList();
    }
    if (this.favoriteNutritions != null) {
      data['favoriteNutritions'] =
          this.favoriteNutritions.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class NutritionData {
  String imagePath;
  String nameEN;
  List<Steps> steps;
  String feddingTime;
  String nameDE;
  bool deleted;
  String thumbnailPath;
  List<Ingredients> ingredients;
  String time;
  int id;
  String category;
  bool favorite;
  String energy;

  NutritionData(
      {this.imagePath,
        this.nameEN,
        this.steps,
        this.feddingTime,
        this.nameDE,
        this.deleted,
        this.thumbnailPath,
        this.ingredients,
        this.time,
        this.id,
        this.category,
        this.favorite,
        this.energy});

  NutritionData.fromJson(Map<String, dynamic> json) {
    imagePath = json['imagePath'];
    nameEN = json['nameEN'];
    if (json['steps'] != null) {
      steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
    feddingTime = json['feddingTime'];
    nameDE = json['nameDE'];
    deleted = json['deleted'];
    thumbnailPath = json['thumbnailPath'];
    if (json['ingredients'] != null) {
      ingredients = new List<Ingredients>();
      json['ingredients'].forEach((v) {
        ingredients.add(new Ingredients.fromJson(v));
      });
    }
    time = json['time'];
    id = json['id'];
    category = json['category'];
    favorite = json['favorite'];
    energy = json['energy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagePath'] = this.imagePath;
    data['nameEN'] = this.nameEN;
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    data['feddingTime'] = this.feddingTime;
    data['nameDE'] = this.nameDE;
    data['deleted'] = this.deleted;
    data['thumbnailPath'] = this.thumbnailPath;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients.map((v) => v.toJson()).toList();
    }
    data['time'] = this.time;
    data['id'] = this.id;
    data['category'] = this.category;
    data['favorite'] = this.favorite;
    data['energy'] = this.energy;
    return data;
  }
}

class Steps {
  String itemEN;
  String nutritionId;
  String itemDE;
  int id;

  Steps({this.itemEN, this.nutritionId, this.itemDE, this.id});

  Steps.fromJson(Map<String, dynamic> json) {
    itemEN = json['itemEN'];
    nutritionId = json['nutrition_id'];
    itemDE = json['itemDE'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemEN'] = this.itemEN;
    data['nutrition_id'] = this.nutritionId;
    data['itemDE'] = this.itemDE;
    data['id'] = this.id;
    return data;
  }
}

class Ingredients {
  int id;
  String itemDE;
  String itemEN;
  String nutrition_id;

  Ingredients({this.id, this.itemDE, this.itemEN, this.nutrition_id});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemDE = json['itemDE'];
    itemEN = json['itemEN'];
    nutrition_id = json['nutrition_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemDE'] = this.itemDE;
    data['itemEN'] = this.itemEN;
    return data;
  }
}