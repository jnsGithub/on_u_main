import 'package:flutter/material.dart';
import 'package:on_u/component/color/color.dart';



class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('문의하기'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 80),child: Column(
            children: [
              Text('모든 문의는 아래'),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('이메일',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  Text(' 또는 '),
                  Text('대표번호',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  Text('로 연락주시면'),
                ],
              ),
              SizedBox(height: 10,),
              Text('도움드리겠습니다'),
            ],
          ),),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 16),
            width: size.width,
            height: 50,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail,color: mainColor,),
                Text('  JnS_Solution@gmail.com',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
              ],
            ),
          ),
          const SizedBox(height: 22,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 16),
            width: size.width,
            height: 50,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_iphone,color: mainColor,),
                Text('  070-4307-5138',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
              ],
            ),
          )
        ],
      ),
    );
  }
}



