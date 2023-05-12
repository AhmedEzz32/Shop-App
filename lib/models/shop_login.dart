class SocialLoginModel {
  bool? status;
  String? message; // change to non-nullable string
  UserData? data;

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  int? points;
  int? credit;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  // UserData({
  //   this.email,
  //   this.phone,
  //   this.name,
  //   this.id,
  //   this.credit,
  //   this.image,
  //   this.points,
  //   this.token,
  // });

  // namedContractor...> da zy aly fo2 bs by3ml 3ml tany w data gyaly fy shakl map
  UserData.fromJson(Map<String, dynamic> json) //ana sametha ay esm
  {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    credit = json['credit'];
    token = json['token'];
    points = json['points'];
  }
}
