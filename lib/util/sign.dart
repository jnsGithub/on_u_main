import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_u/global.dart';


class Sign{
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password, String passwordCheck, String companyCode, String companyName, String name) async {
    try {
      if(password != passwordCheck) {
        return false;
      }
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = userCredential.user!.uid;

      await db.collection('users').doc(uid).set({
        'email': userCredential.user!.email,
        'companyCode': companyCode,
        'companyName': companyName,
        'name': name,
      });
      await initChatRoom(uid, name, companyName);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future initChatRoom(String? uid, String name, String companyName) async {
    try {
      QuerySnapshot snapshot = await db.collection('counselor').get();
      for (DocumentSnapshot document in snapshot.docs) {
        await db.collection('chatRoom').add({
          'userId': uid,
          'counselorId': document.id,
          'lastChatDate': DateTime.now(),
          'lastChat': '대화가 없습니다.',
          'isReadUser': true,
          'isReadCounselor': false,
          'lastSenderId': '',
          'userName': name,
          'companyName': companyName,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = userCredential.user!.uid;
      print(userCredential.user!.uid);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async { // TODO: 로그아웃 구현해야함
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> findPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> deleteAccount() async {
    try {
      await auth.currentUser!.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkEmail(String email) async {
    QuerySnapshot querySnapshot = await db.collection('users').where('email', isEqualTo: email).get();
    if(querySnapshot.docs.isNotEmpty) {
      return false;
    }
    else return true;
  }



  Future checkCompany(String companyName, String companyCode) async {
    if(companyName == '') {
      if(!Get.isSnackbarOpen) {
        Get.snackbar('입력 오류', '회사명 입력 후 인증을 완료해주세요.');
      }
      print('회사 코드 공백');
      return false;
    }
    try {
      DocumentSnapshot company = await db.collection('company').doc(companyName).get();
      if(companyCode == company['companyCode'] && companyName == company.id) {
        return true;
      }
      else if(companyName != company.id) {
        if(!Get.isSnackbarOpen) Get.snackbar('회사명 오류', '회사명을 확인해주세요.');
        return false;
      }
      else {
        if(!Get.isSnackbarOpen) Get.snackbar('인증 오류', '티켓 코드를 확인해주세요.');
        return false;
      }
    } catch (e) {
      print(e);
      if(!Get.isSnackbarOpen) Get.snackbar('회사명 오류', '회사명을 확인해주세요.');
      return false;
    }
  }
}