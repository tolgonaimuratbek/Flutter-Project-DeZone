import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:de_zone/model/user_auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

//Daten von firestore werden zuerst in json umgewandelt
final usersRef = FirebaseFirestore.instance
    .collection('users')
    .withConverter<UserModel>(
      fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

//Nutzerdaten um mit denen arbeiten zu können
//verwendet in Chat, Kontaktliste, NavigationsBar, Accountseite, SeitenBar
class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  List<UserModel> listAllUsers = [];
  bool isAuth = false;
  UserModel? partner;
  setUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  //setter
  setPatner(UserModel? user) {
    partner = user;
    notifyListeners();
  }

  //Passwort in der Account_Seite ändern (später wird der Nutzer Email, Name und
  // andere Daten ändern können)
  Future<bool> editEmail(
      String oldPassword, String newEmail, String newPassword) async {
    FirebaseAuth.instance.signOut();
    var res = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: newEmail!, password: oldPassword);
    if (res.user != null) {
      res.user!.updateEmail(newEmail);
      res.user!.updatePassword(newPassword);
      return true;
    } else {
      return false;
    }
  }

  //verwendet in der NavigationsBar, Nutzer wird mit ID geholt
  Future<UserModel?> getUserById(String? id) async {
    if (id != null) {
      var user =
          await usersRef.doc(id).get().then((snapshot) => snapshot.data()!);
      currentUser = user;
      notifyListeners();
      return user;
    } else {
      return null;
    }
  }

  //existierende Nutzer außer den angemeldeten holen verwendet in der
  // Kontaktliste
  Future<void> fetchAllUsers() async {
    listAllUsers = [];
    var result = await usersRef.get();
    for (var sn in result.docs) {
      UserModel user = sn.data();
      if (user.uid != currentUser!.uid) {
        listAllUsers.add(user);
      }
      notifyListeners();
    }
  }
}
