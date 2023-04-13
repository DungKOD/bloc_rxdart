class MessagePage {
  int? currentPage;
  List<Data> data = <Data>[];
  int? from;
  int? lastPage;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  MessagePage(
      {this.currentPage,
      required this.data,
      this.from,
      this.lastPage,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  MessagePage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    from = json['from'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['from'] = from;
    data['last_page'] = lastPage;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  Category? category;
  Author? author;
  String? slug;
  String? title;
  String? body;
  String? language;
  int? follows;
  bool? followed;
  int? totalComment;
  int? status;
  int? votes;
  bool? voted;
  int? createdAt;

  Data(
      {this.id,
      this.category,
      this.author,
      this.slug,
      this.title,
      this.body,
      this.language,
      this.follows,
      this.followed,
      this.totalComment,
      this.status,
      this.votes,
      this.voted,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    slug = json['slug'];
    title = json['title'];
    body = json['body'];
    language = json['language'];
    follows = json['follows'];
    followed = json['followed'];
    totalComment = json['total_comment'];
    status = json['status'];
    votes = json['votes'];
    voted = json['voted'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['slug'] = slug;
    data['title'] = title;
    data['body'] = body;
    data['language'] = language;
    data['follows'] = follows;
    data['followed'] = followed;
    data['total_comment'] = totalComment;
    data['status'] = status;
    data['votes'] = votes;
    data['voted'] = voted;
    data['created_at'] = createdAt;
    return data;
  }
}

class Category {
  String? name;
  String? slug;
  bool? followed;

  Category({this.name, this.slug, this.followed});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['slug'] = slug;
    data['followed'] = followed;
    return data;
  }
}

class Author {
  int? id;
  String? label;
  String? username;
  String? image;
  int? premium;
  int? premiumExpired;

  Author(
      {this.id,
      this.label,
      this.username,
      this.image,
      this.premium,
      this.premiumExpired});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    username = json['username'];
    image = json['image'];
    premium = json['premium'];
    premiumExpired = json['premium_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['username'] = username;
    data['image'] = image;
    data['premium'] = premium;
    data['premium_expired'] = premiumExpired;
    return data;
  }
}
