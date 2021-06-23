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
    return  Scaffold(

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
                                    Utils.NavigatorKeyDate.currentState!
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
