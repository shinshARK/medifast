  class UserModel{
  String firstname;
  String lastname;
  String email;
  String telpon;
  String hashed_password;


  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telpon,
    required this.hashed_password
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      telpon: json['telpon'],
      hashed_password: json['hashed_password'],
    );
  }

}


// ignore: non_constant_identifier_names
var data_user = [
  // Data yang sudah ada
  UserModel(firstname: "wahyu ", lastname: "sanhusi",email: "wahyu@gmail.com", telpon: "0835478853", hashed_password: "hashed_password"),
  UserModel(firstname: "agus",lastname: "william",email: "agus@gmail.com", telpon: "agus@gmail.com", hashed_password: "hashed_password"),
  UserModel(firstname: "rafi",lastname: "ahmad",email: "rafi@gmail.com", telpon: "0835478853", hashed_password: "hashed_password"),
  UserModel(firstname: "odang",lastname: "saluhi",email: "odang@gmail.com", telpon: "0835478853", hashed_password: "hashed_password"),
  UserModel(firstname: "budi",lastname: "gunawan",email: "budi@gmail.com", telpon: "0835478853", hashed_password: "hashed_password")

  // UserModel(firstname: "Dummy1", lastname: "User1",email: "dummy1@gmail.com", telpon: "0835478854", password: "password1"),
  // UserModel(firstname: "Dummy2", lastname: "User2",email: "dummy2@gmail.com", telpon: "0835478855", password: "password2"),
  // UserModel(firstname: "Dummy3", lastname: "User3",email: "dummy3@gmail.com", telpon: "0835478856", password: "password3"),
  // UserModel(firstname: "Dummy4", lastname: "User4",email: "dummy4@gmail.com", telpon: "0835478857", password: "password4"),
  // UserModel(firstname: "Dummy5", lastname: "User5",email: "dummy5@gmail.com", telpon: "0835478858", password: "password5"),
  // UserModel(firstname: "Dummy6", lastname: "User6",email: "dummy6@gmail.com", telpon: "0835478859", password: "password6"),
  // UserModel(firstname: "Dummy7", lastname: "User7",email: "dummy7@gmail.com", telpon: "0835478860", password: "password7"),
  // UserModel(firstname: "Dummy8", lastname: "User8",email: "dummy8@gmail.com", telpon: "0835478861", password: "password8"),
  // UserModel(firstname: "Dummy9", lastname: "User9",email: "dummy9@gmail.com", telpon: "0835478862", password: "password9"),
  // UserModel(firstname: "Dummy10", lastname: "User10",email: "dummy10@gmail.com", telpon: "0835478863", password: "password10"),
  // UserModel(firstname: "Dummy11", lastname: "User11",email: "dummy11@gmail.com", telpon: "0835478864", password: "password11"),
  // UserModel(firstname: "Dummy12", lastname: "User12",email: "dummy12@gmail.com", telpon: "0835478865", password: "password12"),
  // UserModel(firstname: "Dummy13", lastname: "User13",email: "dummy13@gmail.com", telpon: "0835478866", password: "password13"),
  // UserModel(firstname: "Dummy14", lastname: "User14",email: "dummy14@gmail.com", telpon: "0835478867", password: "password14"),
  // UserModel(firstname: "Dummy15", lastname: "User15",email: "dummy15@gmail.com", telpon: "0835478868", password: "password15"),
];


// .fromJson
