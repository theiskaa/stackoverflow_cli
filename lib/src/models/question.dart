class Question {
  List<Items>? items;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  Question({this.items, this.hasMore, this.quotaMax, this.quotaRemaining});

  Question.fromJson(Map<String, dynamic> json) {
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
  List<String>? tags;
  Owner? owner;
  bool? isAnswered;
  int? viewCount;
  int? acceptedAnswerId;
  int? answerCount;
  int? score;
  int? lastActivityDate;
  int? creationDate;
  int? lastEditDate;
  int? questionId;
  String? contentLicense;
  String? link;
  String? title;

  Items(
      {this.tags,
      this.owner,
      this.isAnswered,
      this.viewCount,
      this.acceptedAnswerId,
      this.answerCount,
      this.score,
      this.lastActivityDate,
      this.creationDate,
      this.lastEditDate,
      this.questionId,
      this.contentLicense,
      this.link,
      this.title});

  Items.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    isAnswered = json['is_answered'];
    viewCount = json['view_count'];
    acceptedAnswerId = json['accepted_answer_id'];
    answerCount = json['answer_count'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    creationDate = json['creation_date'];
    lastEditDate = json['last_edit_date'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tags'] = tags;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['is_answered'] = isAnswered;
    data['view_count'] = viewCount;
    data['accepted_answer_id'] = acceptedAnswerId;
    data['answer_count'] = answerCount;
    data['score'] = score;
    data['last_activity_date'] = lastActivityDate;
    data['creation_date'] = creationDate;
    data['last_edit_date'] = lastEditDate;
    data['question_id'] = questionId;
    data['content_license'] = contentLicense;
    data['link'] = link;
    data['title'] = title;
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
