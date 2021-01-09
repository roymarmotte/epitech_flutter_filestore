class Ingredient {
  String title;
  bool presence;

  Ingredient.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        presence = json['presence'];
  Map<String, dynamic> toJson() => {'title': title, 'presence': presence};

  Ingredient(this.title, this.presence);
}
