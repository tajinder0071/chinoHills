class TabListModel {
  bool? success;
  List<CustomTab>? customTabs;

  TabListModel({
    this.success,
    this.customTabs,
  });

  factory TabListModel.fromJson(Map<String, dynamic> json) => TabListModel(
    success: json["success"],
    customTabs: json["customTabs"] == null ? [] : List<CustomTab>.from(json["customTabs"]!.map((x) => CustomTab.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "customTabs": customTabs == null ? [] : List<dynamic>.from(customTabs!.map((x) => x.toJson())),
  };
}

class CustomTab {
  int? categoryId;
  String? categoryTabName;

  CustomTab({
    this.categoryId,
    this.categoryTabName,
  });

  factory CustomTab.fromJson(Map<String, dynamic> json) => CustomTab(
    categoryId: json["category_id"],
    categoryTabName: json["category_tab_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_tab_name": categoryTabName,
  };
}
