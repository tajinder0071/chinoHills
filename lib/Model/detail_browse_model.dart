class DetailBrowseModel {
  String? message;
  bool? success;
  BrowseData? data;

  DetailBrowseModel({
    this.message,
    this.success,
    this.data,
  });

  factory DetailBrowseModel.fromJson(Map<String, dynamic> json) =>
      DetailBrowseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : BrowseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data?.toJson(),
  };
}

class BrowseData {
  HeaderDetails? headerDetails;
  var membershipHeader;
  List<MembershipPerk>? membershipPerks;
  List<Membership>? memberships;
  List<OfferCards>? offerCards;
  List<BrowseCategory>? browseCategories;
  List<BestSelling>? bestSelling;

  BrowseData({
    this.headerDetails,
    this.membershipPerks,
    this.membershipHeader,
    this.memberships,
    this.bestSelling,
    this.offerCards,
    this.browseCategories,
  });

  factory BrowseData.fromJson(Map<String, dynamic> json) => BrowseData(
    headerDetails: json["headerDetails"] == null
        ? null
        : HeaderDetails.fromJson(json["headerDetails"]),
    membershipHeader: json["memberships_perks_header"],
    membershipPerks: json["membershipPerks"] == null
        ? []
        : List<MembershipPerk>.from(json["membershipPerks"]!
        .map((x) => MembershipPerk.fromJson(x))),
    bestSelling: json["best_selling"] == null
        ? []
        : List<BestSelling>.from(
        json["best_selling"]!.map((x) => BestSelling.fromJson(x))),
    offerCards: json["offerCards"] == null
        ? []
        : List<OfferCards>.from(
        json["offerCards"]!.map((x) => OfferCards.fromJson(x))),
    memberships: json["memberships"] == null
        ? []
        : List<Membership>.from(
        json["memberships"]!.map((x) => Membership.fromJson(x))),
    browseCategories: json["browseCategories"] == null
        ? []
        : List<BrowseCategory>.from(json["browseCategories"]!
        .map((x) => BrowseCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "headerDetails": headerDetails?.toJson(),
    "memberships_perks_header": membershipHeader,
    "membershipPerks": membershipPerks == null
        ? []
        : List<dynamic>.from(membershipPerks!.map((x) => x.toJson())),
    "memberships": memberships == null
        ? []
        : List<dynamic>.from(memberships!.map((x) => x.toJson())),
    "best_selling": bestSelling == null
        ? []
        : List<dynamic>.from(bestSelling!.map((x) => x.toJson())),
    "offerCards": offerCards == null
        ? []
        : List<dynamic>.from(offerCards!.map((x) => x)),
    "browseCategories": browseCategories == null
        ? []
        : List<dynamic>.from(browseCategories!.map((x) => x.toJson())),
  };
}

class BrowseCategory {
  String? categoryDescription;
  var id;
  String? categoryHeader;
  String? headerimage;
  var categoryTabName;

  BrowseCategory({
    this.categoryDescription,
    this.id,
    this.categoryHeader,
    this.headerimage,
    this.categoryTabName,
  });

  factory BrowseCategory.fromJson(Map<String, dynamic> json) => BrowseCategory(
    categoryDescription: json["category_description"],
    id: json["id"],
    categoryHeader: json["category_header"],
    headerimage: json["headerimage"],
    categoryTabName: json["category_tab_name"],
  );

  Map<String, dynamic> toJson() => {
    "category_description": categoryDescription,
    "id": id,
    "category_header": categoryHeader,
    "headerimage": headerimage,
    "category_tab_name": categoryTabName,
  };
}

class HeaderDetails {
  var clientId;
  String? browseServices;
  String? promotiontitle;
  String? mainheader;
  String? promotiondetails;
  String? headerimage;

  HeaderDetails({
    this.clientId,
    this.browseServices,
    this.promotiontitle,
    this.mainheader,
    this.promotiondetails,
    this.headerimage,
  });

  factory HeaderDetails.fromJson(Map<String, dynamic> json) => HeaderDetails(
    clientId: json["client_id"],
    browseServices: json["browse_services"],
    promotiontitle: json["promotiontitle"],
    mainheader: json["mainheader"],
    promotiondetails: json["promotiondetails"],
    headerimage: json["headerimage"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "browse_services": browseServices,
    "promotiontitle": promotiontitle,
    "mainheader": mainheader,
    "promotiondetails": promotiondetails,
    "headerimage": headerimage,
  };
}

class MembershipPerk {
  String? membershipIcon;
  String? membershipPerk;

  MembershipPerk({
    this.membershipIcon,
    this.membershipPerk,
  });

  factory MembershipPerk.fromJson(Map<String, dynamic> json) => MembershipPerk(
    membershipIcon: json["membership_icon"],
    membershipPerk: json["membership_perk"],
  );

  Map<String, dynamic> toJson() => {
    "membership_icon": membershipIcon,
    "membership_perk": membershipPerk,
  };
}

class Membership {
  var membershipPricing;
  String? offeroffText;
  var membershipId;
  String? membershipTitle;
  String? membershipDescription;
  String? membershipImage;

  Membership({
    this.membershipPricing,
    this.offeroffText,
    this.membershipId,
    this.membershipTitle,
    this.membershipDescription,
    this.membershipImage,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    membershipPricing: json["membership_pricing"],
    offeroffText: json["offeroffText"],
    membershipId: json["membership_id"],
    membershipTitle: json["membership_title"],
    membershipDescription: json["membership_description"],
    membershipImage: json["membership_image"],
  );

  Map<String, dynamic> toJson() => {
    "membership_pricing": membershipPricing,
    "offeroffText": offeroffText,
    "membership_id": membershipId,
    "membership_title": membershipTitle,
    "membership_description": membershipDescription,
    "membership_image": membershipImage,
  };
}

class OfferCards {
  String? image;
  String? description;
  String? endDate;
  String? title;
  String? startDate;
  var id;

  OfferCards({
    this.image,
    this.description,
    this.endDate,
    this.title,
    this.startDate,
    this.id,
  });

  factory OfferCards.fromJson(Map<String, dynamic> json) => OfferCards(
    image: json["image"],
    description: json["description"],
    endDate: json["end_date"],
    title: json["title"],
    startDate: json["start_date"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "description": description,
    "end_date": endDate,
    "title": title,
    "start_date": startDate,
    "id": id,
  };
}

class BestSelling {
  String? membershipOfferPrice;
  String? itemImage;
  var itemId;
  String? itemType;
  String? itemPrice;
  String? itemName;
  String? offerText;

  BestSelling({
    this.membershipOfferPrice,
    this.itemImage,
    this.itemId,
    this.itemType,
    this.itemPrice,
    this.itemName,
    this.offerText,
  });

  factory BestSelling.fromJson(Map<String, dynamic> json) => BestSelling(
    membershipOfferPrice: json["membership_offer_price"],
    itemImage: json["item_image"],
    itemId: json["item_id"],
    itemType: json["item_type"],
    itemPrice: json["item_price"],
    itemName: json["item_name"],
    offerText: json["offer_text"],
  );

  Map<String, dynamic> toJson() => {
    "membership_offer_price": membershipOfferPrice,
    "item_image": itemImage,
    "item_id": itemId,
    "item_type": itemType,
    "item_price": itemPrice,
    "item_name": itemName,
    "offer_text": offerText,
  };
}
