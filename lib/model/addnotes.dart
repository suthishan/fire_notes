class AddUserModel {
  String email;

  String firstname;

  String lastname;
  // String adduserID;

  AddUserModel({this.firstname = '', this.lastname = '', this.email = ''});

  factory AddUserModel.fromJson(Map<String, dynamic> parsedJson) {
    return new AddUserModel(
      // adduserID: parsedJson['adduserID'] ?? '',
      firstname: parsedJson['firstname'] ?? '',
      lastname: parsedJson['lastname'] ?? '',
      email: parsedJson['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'adduserID': this.adduserID,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'email': this.email,
    };
  }
}
