import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:maak/models/appointment.dart';
import 'package:maak/models/service_details.dart';
import 'package:maak/providers/appointmen_provider.dart';
import 'package:maak/widgets/appointmen_widget.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class appointmenScreen extends StatefulWidget {
  const appointmenScreen({Key? key}) : super(key: key);

  @override
  _appointmenScreenState createState() => _appointmenScreenState();
}

class _appointmenScreenState extends State<appointmenScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
 late  Future<List<Appointment>> _appointment;
  @override
  void initState() {

    _tabController = new TabController(length: 2, vsync: this);
    _appointment = Provider.of<appointmenProvider>(context, listen: false).getAppointment();
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
          child: FutureBuilder<List<Appointment>>(
                  future:_appointment ,
                  builder: (context, AsyncSnapshot snapshot){
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.error != null) {
                        return Text(snapshot.error.toString());
                      }
                    }
                    if (snapshot.hasData) {

                      return ListView.builder(
                        itemBuilder: (ctx, index) {
                          return appointmenWidget(
                            appointment: Appointment(serviceDetails:snapshot.data![index].serviceDetails,
                               address: snapshot.data![index].address,
                                lat:snapshot.data![index].lat,lng:snapshot.data![index].lng)
                            ,ser: ser,);
                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                    else {
                      print('this data null ${snapshot.data}');
                      return Center(child: Text('error'));
                    }
                    }

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
