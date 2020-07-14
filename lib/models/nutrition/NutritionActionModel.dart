class NutritionActionModel {
  int userId;
  int nutritionId;
  bool favorite;

  NutritionActionModel({this.userId, this.nutritionId, this.favorite});

  NutritionActionModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nutritionId = json['nutritionId'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['nutritionId'] = this.nutritionId;
    data['favorite'] = this.favorite;
    return data;
  }
}
