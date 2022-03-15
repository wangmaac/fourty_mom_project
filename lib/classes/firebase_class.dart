import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../utilities/date_format.dart';

class FirebaseMethod {
  late FirebaseFirestore _firebaseFirestore;
  late User _user;

  Future initFirestore() async {
    _firebaseFirestore = FirebaseFirestore.instance;
    _user = FirebaseAuth.instance.currentUser!;
  }

  Future<bool> initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      return true;
    } catch (e) {
      return false;
    }
  }

  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  User get user => _user;

  Future init() async {
    await Firebase.initializeApp();
  }

  Future setFirestoreUser() async {
    await _firebaseFirestore
        .collection('User')
        .doc(_user.uid)
        .set({'mail': '${_user.email}'});
  }

  Future setFirestoreReading(String content, DateTime targetDate) async {
    await _firebaseFirestore
        .collection('Reading')
        .doc(normalFormat.format(targetDate) + _user.uid)
        .set({'user': _user.uid, 'content': content});
  }

  Future setFirestoreWatching(String content, DateTime targetDate) async {
    await _firebaseFirestore
        .collection('Watching')
        .doc(normalFormat.format(targetDate) + _user.uid)
        .set({'user': _user.uid, 'content': content});
  }

  Future setFirestoreListening(String content, DateTime targetDate) async {
    await _firebaseFirestore
        .collection('Listening')
        .doc(normalFormat.format(targetDate) + _user.uid)
        .set({'user': _user.uid, 'content': content});
  }

  void getFirestoreReading() async {
    /*var doc =
        await _firebaseFirestore.collection('Reading').doc('20220311').get();
    var content = doc.get('content');
    logger.d(content.toString());*/
  }
}
