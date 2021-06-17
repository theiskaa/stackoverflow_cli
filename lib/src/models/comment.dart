class Comment {
  List<Items>? items;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  Comment({
    this.items,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  Comment.fromJson(Map<String, dynamic> json) {
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
  bool? edited;
  int? score;
  int? creationDate;
  int? postId;
  int? commentId;
  String? contentLicense;

  Items({
    this.owner,
    this.edited,
    this.score,
    this.creationDate,
    this.postId,
    this.commentId,
    this.contentLicense,
  });

  Items.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    edited = json['edited'];
    score = json['score'];
    creationDate = json['creation_date'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    contentLicense = json['content_license'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['edited'] = edited;
    data['score'] = score;
    data['creation_date'] = creationDate;
    data['post_id'] = postId;
    data['comment_id'] = commentId;
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
