import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/providers/utils.dart';

// ignore: camel_case_types
class appointmenScreen extends StatefulWidget {
  const appointmenScreen({Key? key}) : super(key: key);

  @override
  _appointmenScreenState createState() => _appointmenScreenState();
}

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
          if (ser == 0) Text("Upcoming Appointment"),
          if (ser == 1) Text("Past Appointment"),
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
        height: SizeConfig.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.green),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(15)),
              width: SizeConfig.width * 0.8,
              height: SizeConfig.height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Homs , Syria'),
                      SizedBox(height: SizeConfig.height * 0.01),
                      Text(
                        '33.245 , 45432432',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                  if (ser == 0)
                    ElevatedButton(
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all<Size>(Size(25, 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {},
                      child: Text("Edit"),
                    ),
                ],
              ),
            ),
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
              'Date',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.green),
            ),
            SizedBox(
              height: SizeConfig.height * 0.01,
            ),
            Text(
              '12 June, 2021',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: SizeConfig.height * 0.03,
            ),
            Text(
              'Time',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.green),
            ),
            SizedBox(
              height: SizeConfig.height * 0.01,
            ),
            Text(
              '11:00 AM',
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

class _appointmenScreenState extends State<appointmenScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var SizeConfig = MediaQuery.of(context).size;
    Widget service(int ser) {
      return Flexible(
        flex: 8,
        child: Container(
          width: SizeConfig.width * 0.70,
          height: SizeConfig.height * 0.7,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    showAlertDialog(context, ser);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(13)),
                    width: SizeConfig.width * 0.030,
                    height: SizeConfig.height * 0.30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Vector_Art2.svg",
                          height: 120,
                          width: 140,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Nursing Service"),
                        )
                      ],
                    ),
                  ),
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
          Text(
            "View Your Appointments",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.green,
            tabs: [
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "Past",
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConfig.height * 0.03,
                      ),
                      service(0)
                    ],
                  ),
                ),

                // Container(
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       SizedBox(
                //         height: SizeConfig.height * 0.02,
                //       ),
                //       Text("Follow Up",
                //           style: Theme.of(context)
                //               .textTheme
                //               .bodyText1!
                //               .copyWith(
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.green)),
                //       SizedBox(
                //         height: SizeConfig.height * 0.03,
                //       ),
                //       service(2)
                //     ],
                //   ),
                // ),

                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: SizeConfig.height * 0.03,
                      ),
                      service(1)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
