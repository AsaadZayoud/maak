import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maak/models/service_details.dart';
import 'package:maak/providers/service_provider.dart';
import 'package:maak/widgets/service_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<ServiceDetails>> _futureAvailable;

  void initState() {
    _futureAvailable =
        Provider.of<ServiceProvider>(context, listen: false).availableSer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(child:     Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
      Text('View By Date',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
            Icon(Icons.search),
        ],),
        Flexible(
        flex: 8,
        child: Container(
            color: Theme.of(context).canvasColor,
        child: FutureBuilder<List<ServiceDetails>>(
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
        onTap: () {},
        child: Container(
        padding: EdgeInsets.all(8),
        child: ServiceWidget(
        title: snapshot.data![index].title,
        color: snapshot.data![index].color,
        subtitle:
        '''Date: 12 June, 2021\nTime: 12:00 PM
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
        )
        )
        ),
      ],
    )
    );
  }
}
