class TermConditionModel {
  String? title;
  String? content;

  TermConditionModel({
    this.title,
    this.content,
  });

  factory TermConditionModel.fromJson(Map<String, dynamic> json) => TermConditionModel(
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };
}
