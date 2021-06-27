import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: camel_case_types
class appointmenScreen extends StatefulWidget {
  const appointmenScreen({Key? key}) : super(key: key);

  @override
  _appointmenScreenState createState() => _appointmenScreenState();
}

class _appointmenScreenState extends State<appointmenScreen> {
  @override
  Widget build(BuildContext context) {
    var SizeConfig = MediaQuery.of(context).size;
    Widget service(){
    return  Flexible(
        flex: 8,
        child: Container(
          width: SizeConfig.width*0.20,
          height: SizeConfig.height*0.656,
          child: ListView.builder(

            shrinkWrap:true ,

            itemCount: 5,
            itemBuilder: (ctx, index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(13)),

                  width: SizeConfig.width*0.018,
                  height:SizeConfig.height*0.13,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/Vector_Art2.svg",
                           height: 50,
                        width: 50,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10),
                        child: Text("Nursing Service"
                        ),
                      )
                    ],),
                ),
              );
            },

          ),
        ),
      );
    }


    return Container(
child: Column(
  children: [
  Text("View Your Appointments",style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),),

  Padding(
    padding: const EdgeInsets.all(30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Upcoming",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(height: SizeConfig.height*0.03,),
                   service()

            ],
          ),

        ),
        SizedBox(width: SizeConfig.width*0.07,),
        Container(
          width: 1,
          height: SizeConfig.height*0.7,
          color: Colors.grey.shade300,
        ),
        SizedBox(width: SizeConfig.width*0.07,),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Past",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: Colors.green)),
              SizedBox(height: SizeConfig.height*0.03,),
              service()

            ],
          ),

        ),
        SizedBox(width: SizeConfig.width*0.05,),
        Container(
          width: 1,
          height: SizeConfig.height*0.7,
          color: Colors.grey.shade300,
        ),
        SizedBox(width: SizeConfig.width*0.05,),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Follow Up",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: Colors.green)),
              SizedBox(height: SizeConfig.height*0.03,),
              service()
            ],
          ),
        ),


      ],
    ),
  ),

],),

    );
  }
}
