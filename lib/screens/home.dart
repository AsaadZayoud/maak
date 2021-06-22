import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/models/service.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/nav.dart';
import 'package:maak/screens/profile_screen.dart';
import 'package:maak/widgets/ads_list.dart';
import 'package:maak/widgets/category_list.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _SerState createState() => _SerState();
}

class _SerState extends State<Home> {
  late Future<List<Service>> _futureAvailable;

  @override
  void initState() {
    _futureAvailable =
        Provider.of<ServiceProvider>(context, listen: false).available();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      leading: Align(
        alignment: Alignment.topCenter
        ,
        child: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              'assets/svg/drawer.svg',
              height: 15,
              width: 34,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      title:      Align(
        alignment:lan.isEn ?  Alignment.bottomRight : Alignment.bottomLeft,
        child: GestureDetector(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
              ),
            ),
          ),
        ),
      ) ,


    ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "${lan.getTexts('ads')}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Flexible(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AdsList(),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "${lan.getTexts('service')}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Flexible(
                  flex: 8,
                  child: Container(
                      color: Theme.of(context).canvasColor,
                      child: FutureBuilder<List<Service>>(
                        future: _futureAvailable,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
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
                                    onTap: () {
                                      Utils.NavigatorKey.currentState!
                                          .pushNamed('/calendar');
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: ServiceWidget(
                                        title: snapshot.data![index].title,
                                        color: snapshot.data![index].color,
                                        subtitle: snapshot.data![index].subtitle,
                                        svg: snapshot.data![index].svg,
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
