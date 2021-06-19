import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _buttonText(BuildContext context,String _link, String _text){
    return TextButton(onPressed: ()=>{}
    , child: Text(_text,));
  }


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Profile'),),
      ),
      body: Column(
        children: [
          SizedBox(height: deviceSize.height*0.03,),
          Container(
            color: Theme.of(context).accentColor,
            height: deviceSize.height*0.1,
             width: deviceSize.width,
            child: ListTile(

              leading: CircleAvatar(
                backgroundImage: Image.asset('assets/images/placeholder.png').image,
              ) ,
              title: Text('asaad'),
              subtitle: Text('Mobile app'),
            ),
          ),
          SizedBox(height: deviceSize.height*0.03,),
          Container(
            height: deviceSize.height*0.2,
            color: Theme.of(context).accentColor,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 Text('About Me',style: TextStyle(fontWeight: FontWeight.bold),),
                 Text('my name asaad '),
                 Divider(color: Colors.black87,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [

                   IconButton(onPressed: ()=>{}, icon: Icon(Icons.home,size: 40,),

                   ),
                   IconButton(onPressed: ()=>{}, icon: Icon(Icons.link,size: 40,)
                   )
                 ],)
               ],
             ),
           ),
          ),
          SizedBox(height: deviceSize.height*0.03,),
          Container(
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                _buttonText(context,'df','Family Members'),
                Divider(color: Colors.black87,),
                _buttonText(context,'df','Saved Cards'),
                Divider(color: Colors.black87,),
                _buttonText(context,'df','Location'),
                Divider(color: Colors.black87,),
                _buttonText(context,'df','Bill History'),

              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:BottomAppBar(


        child: Row(

         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Container(
             width: deviceSize.width*0.5,
             color: Theme.of(context).accentColor,
             child: TextButton(onPressed: ()=>{}, child: Text('Call For Help',),
             ),
           ),
      Container(
          width: deviceSize.width*0.5,
          color: Theme.of(context).bottomAppBarColor
      ,child: TextButton(onPressed: ()=>{}, child: Text('Call For Help')))
         ],
      ),
      color:Theme.of(context).primaryColor,
      )
    );
  }
}
