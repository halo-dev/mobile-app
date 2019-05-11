class Comment {
	bool isFirst;
	int total;
	int pages;
	int rpp;
	bool isLast;
	bool hasContent;
	bool isEmpty;
	bool hasPrevious;
	bool hasNext;
	int page;
	List<CommentContent> content;

	Comment({this.isFirst, this.total, this.pages, this.rpp, this.isLast, this.hasContent, this.isEmpty, this.hasPrevious, this.hasNext, this.page, this.content});

	Comment.fromJson(Map<String, dynamic> json) {
		isFirst = json['isFirst'];
		total = json['total'];
		pages = json['pages'];
		rpp = json['rpp'];
		isLast = json['isLast'];
		hasContent = json['hasContent'];
		isEmpty = json['isEmpty'];
		hasPrevious = json['hasPrevious'];
		hasNext = json['hasNext'];
		page = json['page'];
		if (json['content'] != null) {
			content = new List<CommentContent>();(json['content'] as List).forEach((v) { content.add(new CommentContent.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isFirst'] = this.isFirst;
		data['total'] = this.total;
		data['pages'] = this.pages;
		data['rpp'] = this.rpp;
		data['isLast'] = this.isLast;
		data['hasContent'] = this.hasContent;
		data['isEmpty'] = this.isEmpty;
		data['hasPrevious'] = this.hasPrevious;
		data['hasNext'] = this.hasNext;
		data['page'] = this.page;
		if (this.content != null) {
      data['content'] =  this.content.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CommentContent {
	String gavatarMd5;
	CommentContentPost post;
	int createTime;
	String author;
	String ipAddress;
	String userAgent;
	int id;
	bool isAdmin;
	String email;
	String content;
	int parentId;
	String status;

	CommentContent({this.gavatarMd5, this.post, this.createTime, this.author, this.ipAddress, this.userAgent, this.id, this.isAdmin, this.email, this.content, this.parentId, this.status});

	CommentContent.fromJson(Map<String, dynamic> json) {
		gavatarMd5 = json['gavatarMd5'];
		post = json['post'] != null ? new CommentContentPost.fromJson(json['post']) : null;
		createTime = json['createTime'];
		author = json['author'];
		ipAddress = json['ipAddress'];
		userAgent = json['userAgent'];
		id = json['id'];
		isAdmin = json['isAdmin'];
		email = json['email'];
		content = json['content'];
		parentId = json['parentId'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['gavatarMd5'] = this.gavatarMd5;
		if (this.post != null) {
      data['post'] = this.post.toJson();
    }
		data['createTime'] = this.createTime;
		data['author'] = this.author;
		data['ipAddress'] = this.ipAddress;
		data['userAgent'] = this.userAgent;
		data['id'] = this.id;
		data['isAdmin'] = this.isAdmin;
		data['email'] = this.email;
		data['content'] = this.content;
		data['parentId'] = this.parentId;
		data['status'] = this.status;
		return data;
	}
}

class CommentContentPost {
	int createTime;
	int updateTime;
	int editTime;
	int id;
	String title;
	dynamic type;
	String url;
	String status;

	CommentContentPost({this.createTime, this.updateTime, this.editTime, this.id, this.title, this.type, this.url, this.status});

	CommentContentPost.fromJson(Map<String, dynamic> json) {
		createTime = json['createTime'];
		updateTime = json['updateTime'];
		editTime = json['editTime'];
		id = json['id'];
		title = json['title'];
		type = json['type'];
		url = json['url'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['createTime'] = this.createTime;
		data['updateTime'] = this.updateTime;
		data['editTime'] = this.editTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		data['url'] = this.url;
		data['status'] = this.status;
		return data;
	}
}
