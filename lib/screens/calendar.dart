import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:location/location.dart';
import 'package:maak/models/service.dart';
import 'package:maak/models/service_details.dart';
import 'package:maak/providers/appointmen_provider.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/map.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  static const routeName = 'calendar';
  LocationData? locationData;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Future<List<ServiceDetails>> _futureAvailable;

  @override
  void initState() {
    _futureAvailable =
        Provider.of<ServiceProvider>(context, listen: false).availableSer();
    super.initState();
  }

  Location location = new Location();
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  Future<void> _getUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {}
    }

    widget.locationData = await location.getLocation();
    print("vvvv" + widget.locationData.toString());
    // loc = new Locationn(
    // axis: _locationData.latitude, yais: _locationData.longitude);

    // Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    Widget container(
        {required Color color, int dayInt = 00, String dayText = 'DAY'}) {
      return Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$dayInt'),
            Text(dayText),
          ],
        )),
      );
    }

    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TableCalendar(
                locale: lan.isEn ? 'en' : 'ar',
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
//headerMargin: EdgeInsets.only(left: 100),
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (BuildContext context, DateTime time) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${DateFormat('MMMM',lan.isEn ? 'en' : 'ar').format(_focusedDay)}${_focusedDay.year}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        IconButton(
                            onPressed: () {
                              Utils.NavigatorKey.currentState!
                                  .pushReplacementNamed('/search');
                            },
                            icon: Icon(Icons.search)),
                      ],
                    );
                  },
                  selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                           lan.isEn? DateFormat('EEEE','en')
                                 .format(_selectedDay)
                                .substring(0, 3) : DateFormat('EEEE','ar')
                               .format(_selectedDay),
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          )
                        ],
                      )),
                  todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  markerBuilder:
                      (BuildContext ctx, DateTime time, List<dynamic> list) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      width: 16.0,
                      height: 16.0,
                      child: Center(),
                    );
                  },
                ),
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 360)),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
// Use `selectedDayPredicate` to determine which day is currently selected.
// If this returns true, then `day` will be marked as selected.

// Using `isSameDay` is recommended to disregard
// the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {

                  if (!isSameDay(_selectedDay, selectedDay)) {
// Call `setState()` when updating the selected day
// print('${_selectedDay.toString()}');
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {

// Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
// No need to call `setState()` here

                  _focusedDay = focusedDay;
                },
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    container(
                        color: Colors.green,
                        dayInt: _selectedDay.day,
                        dayText: lan.isEn ? DateFormat('EEEE')
                            .format(_selectedDay)
                            .substring(0, 3) : DateFormat('EEEE','ar')
                            .format(_selectedDay)) ,
                    Text(
                      '${lan.getTexts('data_range')}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    container(
                        color: Colors.grey,
                        dayInt: DateTime.now().day,
                        dayText: lan.isEn ? DateFormat('EEEE')
                            .format(DateTime.now())
                            .substring(0, 3) :DateFormat('EEEE','ar')
                            .format(DateTime.now())  ),
                  ],
                ),
              ),
              Flexible(
                  flex: 8,
                  child: Container(
                      color: Theme.of(context).canvasColor,
                      child: FutureBuilder<List<ServiceDetails>>(
                        future: _futureAvailable,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (snapshot.error != null) {
                              return Text(snapshot.error.toString());
                            }

                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await _getUserLocation();
                                      Provider.of<appointmenProvider>(context,
                                              listen: false)
                                          .serviceDetails(
                                              snapshot.data![index]);
                                      //      Utils.NavigatorKey.currentState!.pushReplacementNamed('/map');

                                      Utils.NavigatorKey.currentState!
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) =>
                                                  LocationmapPage(
                                                    locationData:
                                                        widget.locationData,
                                                  )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: ServiceWidget(
                                        title: snapshot.data![index].title,
                                        color: snapshot.data![index].color,
                                        subtitle:
                                            '''${snapshot.data![index].subtitle}\n${snapshot.data![index].time}
                                      ''',
                                        svg: snapshot.data![index].svg,
                                        isDetails: true,
                                        isAvailable:
                                            snapshot.data![index].isAvailable,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.length,
                              );
                            } else {
                              print('this data null ${snapshot.data}');
                              return Center(child: Text('error'));
                            }
                          }
                        },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
