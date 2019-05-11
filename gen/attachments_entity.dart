class AttachmentsEntity {
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
	List<AttachmantsContent> content;

	AttachmentsEntity({this.isFirst, this.total, this.pages, this.rpp, this.isLast, this.hasContent, this.isEmpty, this.hasPrevious, this.hasNext, this.page, this.content});

	AttachmentsEntity.fromJson(Map<String, dynamic> json) {
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
			content = new List<AttachmantsContent>();(json['content'] as List).forEach((v) { content.add(new AttachmantsContent.fromJson(v)); });
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

class AttachmantsContent {
	String path;
	int size;
	int createTime;
	String name;
	int width;
	String fileKey;
	String mediaType;
	int id;
	String thumbPath;
	String suffix;
	String type;
	int height;

	AttachmantsContent({this.path, this.size, this.createTime, this.name, this.width, this.fileKey, this.mediaType, this.id, this.thumbPath, this.suffix, this.type, this.height});

	AttachmantsContent.fromJson(Map<String, dynamic> json) {
		path = json['path'];
		size = json['size'];
		createTime = json['createTime'];
		name = json['name'];
		width = json['width'];
		fileKey = json['fileKey'];
		mediaType = json['mediaType'];
		id = json['id'];
		thumbPath = json['thumbPath'];
		suffix = json['suffix'];
		type = json['type'];
		height = json['height'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['path'] = this.path;
		data['size'] = this.size;
		data['createTime'] = this.createTime;
		data['name'] = this.name;
		data['width'] = this.width;
		data['fileKey'] = this.fileKey;
		data['mediaType'] = this.mediaType;
		data['id'] = this.id;
		data['thumbPath'] = this.thumbPath;
		data['suffix'] = this.suffix;
		data['type'] = this.type;
		data['height'] = this.height;
		return data;
	}
}
