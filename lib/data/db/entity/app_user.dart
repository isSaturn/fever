import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser {
  String id;
  String name;
  int age;
  String profilePhotoPath;
  String majors = "";
  String bio = "";
  List<String> interests = [];
  String country;
  String state;
  String city;
  String gender;
  String preference;
  bool isOnline;

  AppUser({
    @required this.id,
    @required this.name,
    @required this.age,
    @required this.profilePhotoPath,
    @required this.interests,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.gender,
    @required this.preference,
    @required this.isOnline,
  });

  AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    age = snapshot['age'];
    profilePhotoPath = snapshot['profile_photo_path'];
    majors = snapshot.get('majors') ?? '';
    bio = snapshot.get('bio') ?? '';
    interests = snapshot['interests'].cast<String>();
    country = snapshot['country'];
    state = snapshot['state'];
    city = snapshot['city'];
    gender = snapshot['gender'];
    preference = snapshot['preference'];
    isOnline = snapshot['isOnline'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'profile_photo_path': profilePhotoPath,
      'majors': majors,
      'bio': bio,
      'interests': interests,
      'country': country,
      'state': state,
      'city': city,
      'gender': gender,
      'preference': preference,
      'isOnline': isOnline,
    };
  }
}
