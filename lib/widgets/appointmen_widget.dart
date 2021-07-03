import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/models/appointment.dart';
import 'package:maak/models/service_details.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:provider/provider.dart';

class appointmenWidget extends StatelessWidget {
  Appointment? appointment ;
  int ser;
   appointmenWidget({required this.appointment,required this.ser});

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    showAlertDialog(BuildContext context, int ser) {
      var SizeConfig = MediaQuery.of(context).size;
      // set up the button
      AlertDialog alert;
      // set up the AlertDialog
      if (ser == 0 || ser == 1) {
        alert = AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (ser == 0) Text("${lan.getTexts('upcoming_appointment')}"),
              if (ser == 1) Text("${lan.getTexts('past_appointment')}"),
              IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                icon: SvgPicture.asset(
                    'assets/svg/close.svg'
                ),
              )
            ],
          ),
          content: Container(
              height: SizeConfig.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${lan.getTexts('location')}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15)),
                    width: SizeConfig.width * 0.8,
                    height: SizeConfig.height * 0.17,

                      child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(this.appointment!.address),
                            SizedBox(height: SizeConfig.height * 0.01),
                            Text(
                                "${this.appointment!.lat} , ${this.appointment!.lng}",
                              style: Theme.of(context).textTheme.bodyText1,
                           ),
                            if (ser == 0)
                              ElevatedButton(
                                style: ButtonStyle(

                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        ))),
                                onPressed: () {},
                                child: Text("${lan.getTexts('edit')}"),
                              ),
                          ],
                        ),


                  ),
                ),
                Text(
                  "${lan.getTexts('service')}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.01,
                ),
                Text(
                    this.appointment!.serviceDetails.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: SizeConfig.height * 0.03,
                ),
                Text(
                  "${lan.getTexts('date')}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.01,
                ),
                Text(
                  this.appointment!.serviceDetails.subtitle,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: SizeConfig.height * 0.03,
                ),
                Text(
                  "${lan.getTexts('time')}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.01,
                ),
                Text(
                  this.appointment!.serviceDetails.time,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        );
      } else {
        alert = AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Follow Up Appointment"),
              IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                icon: SvgPicture.asset(
                  'assets/svg/close.svg',
                ),
              )
            ],
          ),
          content: Container(
            height: SizeConfig.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.01,
                ),
                Text(
                  'Nursing Service',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: SizeConfig.height * 0.03,
                ),
                Text(
                  'Tasks',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.green),
                ),
                SizedBox(
                  height: SizeConfig.height * 0.03,
                ),
                Container(
                  height: SizeConfig.height * 0.45,
                  width: SizeConfig.width * 0.77,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green.shade50),
                        margin: EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          title: Text(
                            "Task Name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.green),
                          ),
                          subtitle: Text(
                            "a home medical services service that is provided to various types and forms of care, whether for children, the elderly, physiotherapy, post-operative care and other services.",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }


    var SizeConfig = MediaQuery.of(context).size;
    return  Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: (){
          showAlertDialog(context, this.ser);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(13)),

          height:isPortrait ?  SizeConfig.height * 0.30 : SizeConfig.width*0.30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                this.appointment!.serviceDetails.svg,
                height: 120,
                width: 140,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(this.appointment!.serviceDetails.title),
              )
            ],
          ),
        ),
      ),
    );
  }
}
