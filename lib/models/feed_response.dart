class FeedResponse {
  int? status;
  String? code;
  List<Post>? posts;

  FeedResponse({this.status, this.code, this.posts});

  FeedResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      posts = <Post>[];
      json['data'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['data'] = posts?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Post {
  int? id;
  int? authorId;
  int? communityId;
  String? text;
  String? title;
  bool? likedByUs;
  bool? commentedByUs;
  bool? bookmarked;
  int? timestamp;
  int? totalPostViews;
  bool? isBlured;
  String? authorName;
  String? authorAvatarExtension;
  String? authorAvatarUrl;

  Post(
      {this.id,
      this.authorId,
      this.communityId,
      this.text,
      this.title,
      this.likedByUs,
      this.commentedByUs,
      this.bookmarked,
      this.timestamp,
      this.totalPostViews,
      this.isBlured,
      this.authorName,
      this.authorAvatarExtension,
      this.authorAvatarUrl});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    communityId = json['community_id'];
    text = json['text'];
    title = json['title'];
    likedByUs = json['liked_by_us'];
    commentedByUs = json['commented_by_us'];
    bookmarked = json['bookmarked'];
    timestamp = json['timestamp'];
    totalPostViews = json['total_post_views'];
    isBlured = json['is_blured'];
    authorName = json['author_name'];
    authorAvatarExtension = json['author_avatar_extension'];
    authorAvatarUrl = json['author_avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['author_id'] = authorId;
    data['community_id'] = communityId;
    data['text'] = text;
    data['title'] = title;
    data['liked_by_us'] = likedByUs;
    data['commented_by_us'] = commentedByUs;
    data['bookmarked'] = bookmarked;
    data['timestamp'] = timestamp;
    data['total_post_views'] = totalPostViews;
    data['is_blured'] = isBlured;
    data['author_name'] = authorName;
    data['author_avatar_extension'] = authorAvatarExtension;
    data['author_avatar_url'] = authorAvatarUrl;
    return data;
  }
}
