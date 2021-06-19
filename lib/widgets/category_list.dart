import 'package:flutter/material.dart';
import 'package:maak/widgets/category.dart';

class CategoryList extends StatelessWidget {
  static const routeName = '/categoryList';

  String svg = '';
  Color color = Colors.green;
  String title = '';
  String subtitle = '';
  bool isDetails = false;


  CategoryList(this.svg, this.color, this.title, this.subtitle, this.isDetails);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,i){
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Category(),
              ),
            );
          },
        ),
      ),
    );
  }
}
