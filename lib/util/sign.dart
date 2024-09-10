import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:on_u/global.dart';


class Sign{
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password, String companyCode, String companyName, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await db.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'companyCode': companyCode,
        'companyName': companyName,
        'name': name,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
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
      if(!Get.isSnackbarOpen) Get.snackbar('중복 오류', '이미 가입된 이메일입니다.', backgroundColor: const Color(0xffff0000), colorText: Colors.white);
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