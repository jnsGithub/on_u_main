import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_u/model/program.dart';

class ProgramInfo{
  final db = FirebaseFirestore.instance;

  Future<List<Program>> getProgram() async{
    List<Program> programList = [];
    try {
      QuerySnapshot snapshot = await db.collection('program').get();
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        data['documentId'] = document.id;
        data['photoURL'] = data['photoURL'].cast<String>();
        data['createDate'] = data['createDate'].toDate();
        print(data['photoURL']);
        programList.add(Program.fromJson(data));
        print(data);
      }
      return programList;
    } catch (e) {
      print('프로그램 가져올때 걸림');
      print(e);
      return [];
    }
  }
}