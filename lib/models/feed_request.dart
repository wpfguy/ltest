class FeedRequest {
  FeedRequestData? data;

  FeedRequest({this.data});

  FeedRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? FeedRequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class FeedRequestData {
  int? pageSize;
  String? order;
  int? lastPostId;

  FeedRequestData({this.pageSize, this.order, this.lastPostId});

  FeedRequestData.fromJson(Map<String, dynamic> json) {
    pageSize = json['page_size'];
    order = json['order'];
    lastPostId = json['lpid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page_size'] = pageSize;
    data['order'] = order;
    data['lpid'] = lastPostId;
    return data;
  }
}
