import 'package:montageapp/features/random_user/data/model/user_model.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

final tUserA = User(
    name: "john smith",
    email: "john@example.com",
    userName: "john123",
    password: "johnPassword",
    address: "123 example st, City State",
    gender: "male",
    imgUrl: "assets/man_1.png");

final tUserB = User(
    name: "Alice Smith",
    email: "alice@example.com",
    userName: "alice!@#",
    password: "aSJDIW@KSd293",
    address: "123 town rd, City State",
    gender: "male",
    imgUrl: "assets/man_1.png");

final tMaleUserModel = UserModel(
    name: "Frederik Stenstad",
    email: "frederik.stenstad@example.com",
    userName: "blueswan657",
    password: "steph",
    address: "2391 Armauer Hansens gate, Hyggen, Møre og Romsdal, Norway",
    gender: "male",
    imgUrl: "assets/man_1.png");

final tFemaleUserModel = UserModel(
    name: "Saadia Droste",
    email: "saadia.droste@example.com",
    userName: "tinypeacock811",
    password: "1960",
    address: "9548 De Priorij, Greonterp, Noord-Brabant, Netherlands",
    gender: "female",
    imgUrl: "assets/woman_1.png");

final List assetsMaleUrl = [
  "assets/man_1.png",
  "assets/man_2.png",
  "assets/man_3.png",
  "assets/man_4.png",
  "assets/man_5.png",
  "assets/man_6.png",
  "assets/man_7.png"
];

final List assetsFemaleUrl = [
  "assets/woman_1.png",
  "assets/woman_2.png",
  "assets/woman_3.png",
  "assets/woman_4.png",
  "assets/woman_5.png",
  "assets/woman_6.png",
  "assets/woman_7.png"
];
