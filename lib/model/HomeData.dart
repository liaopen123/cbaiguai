class HomeData {
	List<Data> data;

	HomeData({this.data});

	HomeData.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = new List<Data>();
			json['data'].forEach((v) {
				data.add(new Data.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
			data['data'] = this.data.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class Data {
	int ghostId;
	String ghostName;
	String ghostDes;
	String ghostAvatar;
	String ghostLink;

	Data(
			{this.ghostId,
				this.ghostName,
				this.ghostDes,
				this.ghostAvatar,
				this.ghostLink});

	Data.fromJson(Map<String, dynamic> json) {
		ghostId = json['ghost_id'];
		ghostName = json['ghost_name'];
		ghostDes = json['ghost_des'];
		ghostAvatar = json['ghost_avatar'];
		ghostLink = json['ghost_link'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ghost_id'] = this.ghostId;
		data['ghost_name'] = this.ghostName;
		data['ghost_des'] = this.ghostDes;
		data['ghost_avatar'] = this.ghostAvatar;
		data['ghost_link'] = this.ghostLink;
		return data;
	}
}
