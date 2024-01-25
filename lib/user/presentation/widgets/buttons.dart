import 'package:flutter/material.dart';

class CustomButton {
  customSubmitButton(BuildContext context,String userText) {
    return Container(
      height:MediaQuery.of(context).size.width*0.1,
      width: MediaQuery.of(context).size.width*0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
              colors: [  Color.fromARGB(255, 157, 206, 255),Color.fromARGB(255, 146, 163,253),],),),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child:  Text(userText,style: const TextStyle(
          color:Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
  
  customNextButton(BuildContext context){
    return Container(
      height: 60,
      width: 60,
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
              colors: [  Color.fromARGB(255, 157, 206, 255),Color.fromARGB(255, 146, 163,253),])),
              child: TextButton(onPressed: (){}, child: const Icon(Icons.navigate_next_outlined,color: Colors.white,size:30 ,)),
    );
  }

  loginIconButton(){
    return Container(
      width: 60,
      height: 60,
      decoration:BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 214, 214, 214),width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child:Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset('assets/images/google.png'),
      ),
    );
  }
}
