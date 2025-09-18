import 'detail_browse_model.dart';

class HomeModel {
  String? message;
  bool? success;
  List<HomeDatum>? data;

  HomeModel({this.message, this.success, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = <HomeDatum>[];
      json['data'].forEach((v) {
        data!.add(HomeDatum.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeDatum {
  String? membershipsPerksHeader;
  var unlockSpend;
  String? headerImage;
  String? linkedImage;
  var unlockAtCount;
  List<BestSelling>? bestSelling;
  List<AnnouncementOffers>? announcementOffers;
  List<MembershipPerk>? membershipPerks;
  var clientId;
  var nextRewardId;
  String? color;
  String? subheader;
  List<Membership>? memberships;
  var id;
  List<OfferCards>? offerCards;
  String? mainheader;
  String? concernsImage;

  HomeDatum({
    this.membershipsPerksHeader,
    this.unlockSpend,
    this.headerImage,
    this.linkedImage,
    this.unlockAtCount,
    this.bestSelling,
    this.announcementOffers,
    this.membershipPerks,
    this.clientId,
    this.nextRewardId,
    this.color,
    this.subheader,
    this.memberships,
    this.id,
    this.offerCards,
    this.mainheader,
    this.concernsImage,
  });

  HomeDatum.fromJson(Map<String, dynamic> json) {
    membershipsPerksHeader = json['memberships_perks_header'];
    unlockSpend = json['unlock_spend'];
    headerImage = json['header_image'];
    linkedImage = json['linked_image'];
    unlockAtCount = json['unlock_at_count'];
    if (json['best_selling'] != null) {
      bestSelling = <BestSelling>[];
      json['best_selling'].forEach((v) {
        bestSelling!.add(new BestSelling.fromJson(v));
      });
    }
    if (json['announcement_offers'] != null) {
      announcementOffers = <AnnouncementOffers>[];
      json['announcement_offers'].forEach((v) {
        announcementOffers!.add(new AnnouncementOffers.fromJson(v));
      });
    }
    if (json['membershipPerks'] != null) {
      membershipPerks = <MembershipPerk>[];
      json['membershipPerks'].forEach((v) {
        membershipPerks!.add(new MembershipPerk.fromJson(v));
      });
    }
    clientId = json['client_id'];
    nextRewardId = json['next_reward_id'];
    color = json['color'];
    subheader = json['subheader'];
    if (json['memberships'] != null) {
      memberships = <Membership>[];
      json['memberships'].forEach((v) {
        memberships!.add(new Membership.fromJson(v));
      });
    }
    id = json['id'];
    if (json['offerCards'] != null) {
      offerCards = <OfferCards>[];
      json['offerCards'].forEach((v) {
        offerCards!.add(new OfferCards.fromJson(v));
      });
    }
    mainheader = json['mainheader'];
    concernsImage = json['concerns_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberships_perks_header'] = this.membershipsPerksHeader;
    data['unlock_spend'] = this.unlockSpend;
    data['header_image'] = this.headerImage;
    data['linked_image'] = this.linkedImage;
    data['unlock_at_count'] = this.unlockAtCount;
    if (bestSelling != null) {
      data['best_selling'] = bestSelling!.map((v) => v.toJson()).toList();
    }
    if (announcementOffers != null) {
      data['announcement_offers'] = announcementOffers!
          .map((v) => v.toJson())
          .toList();
    }
    if (membershipPerks != null) {
      data['membershipPerks'] = membershipPerks!
          .map((v) => v.toJson())
          .toList();
    }
    data['client_id'] = this.clientId;
    data['next_reward_id'] = this.nextRewardId;
    data['color'] = this.color;
    data['subheader'] = this.subheader;
    if (memberships != null) {
      data['memberships'] = memberships!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    if (offerCards != null) {
      data['offerCards'] = offerCards!.map((v) => v.toJson()).toList();
    }
    data['mainheader'] = mainheader;
    data['concerns_image'] = concernsImage;
    return data;
  }
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

  BestSelling.fromJson(Map<String, dynamic> json) {
    membershipOfferPrice = json['membership_offer_price'];
    itemImage = json['item_image'];
    itemId = json['item_id'];
    itemType = json['item_type'];
    itemPrice = json['item_price'];
    itemName = json['item_name'];
    offerText = json['offer_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_offer_price'] = this.membershipOfferPrice;
    data['item_image'] = this.itemImage;
    data['item_id'] = this.itemId;
    data['item_type'] = this.itemType;
    data['item_price'] = this.itemPrice;
    data['item_name'] = this.itemName;
    data['offer_text'] = this.offerText;
    return data;
  }
}

class AnnouncementOffers {
  String? image;
  var discountValue;
  String? title;
  var id;
  String? discountType;

  AnnouncementOffers({
    this.image,
    this.discountValue,
    this.title,
    this.id,
    this.discountType,
  });

  AnnouncementOffers.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    discountValue = json['discount_value'];
    title = json['title'];
    id = json['id'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['discount_value'] = this.discountValue;
    data['title'] = this.title;
    data['id'] = this.id;
    data['discount_type'] = this.discountType;
    return data;
  }
}

class MembershipPerk {
  String? membershipIcon;
  String? membershipPerk;

  MembershipPerk({this.membershipIcon, this.membershipPerk});

  MembershipPerk.fromJson(Map<String, dynamic> json) {
    membershipIcon = json['membership_icon'];
    membershipPerk = json['membership_perk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_icon'] = this.membershipIcon;
    data['membership_perk'] = this.membershipPerk;
    return data;
  }
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

  Membership.fromJson(Map<String, dynamic> json) {
    membershipPricing = json['membership_pricing'];
    offeroffText = json['offeroffText'];
    membershipId = json['membership_id'];
    membershipTitle = json['membership_title'];
    membershipDescription = json['membership_description'];
    membershipImage = json['membership_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_pricing'] = this.membershipPricing;
    data['offeroffText'] = this.offeroffText;
    data['membership_id'] = this.membershipId;
    data['membership_title'] = this.membershipTitle;
    data['membership_description'] = this.membershipDescription;
    data['membership_image'] = this.membershipImage;
    return data;
  }
}
