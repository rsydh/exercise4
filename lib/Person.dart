class Person {
  //data type
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? lastseen;
  String? avatar;
  String? status;

  //constructor
  Person(
      {
      this.id,
      this.firstname,
      this.lastname,
      this.username,
      this.lastseen,
      this.avatar,
      this.status
      }
      );

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    username = json['username'];
    lastseen = json['last_seen_time'];
    avatar = json['avatar'];
    status = json['status'];
  }
}