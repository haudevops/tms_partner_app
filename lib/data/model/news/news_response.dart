class NewsResponse {
  NewsResponse(
      {this.unseen, this.total, this.limit, this.page, this.pages, this.data});

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
        unseen: json['unseen'],
        total: json['total'],
        limit: json['limit'],
        page: json['page'],
        pages: json['pages'],
        data: (json['data'] != null)
            ? List<NewsNotificationData>.from(
                json['data'].map((x) => NewsNotificationData.fromJson(x)))
            : null);
  }

  int? unseen;
  int? total;
  int? limit;
  int? page;
  int? pages;
  List<NewsNotificationData>? data;

  @override
  String toString() {
    return 'unseen: $unseen, total: $total';
  }
}

class NewsNotificationData {
  NewsNotificationData(
      {required this.id,
      this.title,
      this.image,
      this.newsCatName,
      this.createdAt,
      this.url});

  factory NewsNotificationData.fromJson(Map<String, dynamic> json) {
    return NewsNotificationData(
        id: json['_id'],
        title: json['title'],
        image: json['image'],
        newsCatName: json['newsCatName'],
        createdAt: json['createdAt'],
        url: json['url']);
  }

  String id;
  String? title;
  String? image;
  String? newsCatName;
  int? createdAt;
  String? url;
}
