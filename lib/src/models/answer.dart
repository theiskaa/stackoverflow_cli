class Answer {
  List<Items>? items;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  Answer({this.items, this.hasMore, this.quotaMax, this.quotaRemaining});

  Answer.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}

class Items {
  Owner? owner;
  bool? isAccepted;
  int? score;
  int? lastActivityDate;
  int? creationDate;
  int? answerId;
  int? questionId;
  String? contentLicense;

  Items({
    this.owner,
    this.isAccepted,
    this.score,
    this.lastActivityDate,
    this.creationDate,
    this.answerId,
    this.questionId,
    this.contentLicense,
  });

  Items.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    isAccepted = json['is_accepted'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    creationDate = json['creation_date'];
    answerId = json['answer_id'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['is_accepted'] = isAccepted;
    data['score'] = score;
    data['last_activity_date'] = lastActivityDate;
    data['creation_date'] = creationDate;
    data['answer_id'] = answerId;
    data['question_id'] = questionId;
    data['content_license'] = contentLicense;
    return data;
  }
}

class Owner {
  int? reputation;
  int? userId;
  String? userType;
  String? profileImage;
  String? displayName;
  String? link;

  Owner({
    this.reputation,
    this.userId,
    this.userType,
    this.profileImage,
    this.displayName,
    this.link,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reputation'] = reputation;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['profile_image'] = profileImage;
    data['display_name'] = displayName;
    data['link'] = link;
    return data;
  }
}
