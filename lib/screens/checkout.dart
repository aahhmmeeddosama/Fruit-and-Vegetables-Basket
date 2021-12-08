import 'package:flutter/material.dart';
import 'home_screen.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController=TextEditingController();
    final TextEditingController emailController=TextEditingController();
    final TextEditingController phoneController=TextEditingController();
    final TextEditingController addressController=TextEditingController();
    final TextEditingController cityController=TextEditingController();


    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Checkout'),
      ),
      bottomNavigationBar: new Container(
        color:  Colors.white,
        child: Row(
          children: [
            Expanded(
              child:
              MaterialButton(
                onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  HomeScreen()),);
                },
                child:Text("Order Now", style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,

              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Custom Information ', style: Theme.of(context).textTheme.headline6,),
            _buildTextFormField(nameController, context, 'Name'),
            _buildTextFormField(phoneController, context, 'Phone'),
            _buildTextFormField(emailController, context, 'Email'),
            Text('Delivery Information ', style: Theme.of(context).textTheme.headline6,),
            _buildTextFormField(addressController, context, 'Address'),
            _buildTextFormField(cityController, context, 'City'),
            Text(' Order Summery ', style: Theme.of(context).textTheme.headline6, ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 10.0, 2.0, 8.0),
                  child: Text("Total:",style: Theme.of(context).textTheme.headline6, ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10.0, 2.0, 8.0),
                  child: Text("\$150"),
                ),
              ],
            ),

          ],

        ),
      ),

    );
  }
  Padding _buildTextFormField(
      TextEditingController controller,
      BuildContext context,
      String labelText,
      ){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Row(children: [
        SizedBox(
          width: 75,
          child: Text(labelText,style: Theme.of(context).textTheme.bodyText1,),
        ),
        Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                isDense:true,
                contentPadding: const EdgeInsets.only(left:10),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
        )
      ],),

    );
  }
}
