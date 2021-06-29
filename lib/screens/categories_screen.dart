import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maak/models/service.dart';
import 'package:maak/providers/language_provider.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/providers/utils.dart';
import 'package:maak/screens/nav/nav.dart';
import 'package:maak/screens/profile_screen.dart';
import 'package:maak/widgets/ads_list.dart';
import 'package:maak/widgets/category_list.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';

class categoriesScreen extends StatefulWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  _categoriesScreenState createState() => _categoriesScreenState();
}

class _categoriesScreenState extends State<categoriesScreen> {
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "${lan.getTexts('ads')}",
              style:Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold,fontFamily: 'Exo'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AdsList(),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "${lan.getTexts('service')}",
              style:Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold,fontFamily: 'Exo'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Flexible(
                flex: 10,
                child: Container(
                    color: Theme.of(context).canvasColor,
                    child: FutureBuilder<List<Service>>(
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
    );
  }
}
