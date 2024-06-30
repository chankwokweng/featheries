import 'package:featheries/constants.dart';
import 'package:featheries/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream ? bookingStream;

  getontheload() async {
    bookingStream = await DatabaseMethods().getBookings();
    setState(() {
      
    });
  }

  @override
  void initState(){
    getontheload();
    super.initState();
  }

  Widget allBookings() {
    return StreamBuilder(
      stream: bookingStream, 
      builder: (context, AsyncSnapshot snapshot){
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        
        return snapshot.hasData? 
          ListView.builder( 
            itemCount: snapshot.data.docs.length,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              // return (Text(ds["Service"]+"/"+ds["Username"]+"/"+ds["UserLoginId"]+"/"+ds.id, 
                // style: myBookingServiceTextStyle,));
              return (ListTile(
                leading: Image.network(ds["Image"]),
                title: Text("${ds["Service"]} on ${ds["Date"]} ${ds["Time"]}"),
                subtitle: Text("Customer:${ds["Username"]}[${ds["UserLoginId"]}]"),
                trailing: IconButton(
                  icon: Icon(Icons.done_outline_rounded),
                  onPressed: () async {
                    await DatabaseMethods().deleteUserBooking(ds.id).then((value) => 
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Booking Completed!")))
                    );
                    },
                ),
                // ) +"/"+ds.id,; 
              ));}
          )
        : 
          Text("No data", style: myBookingServiceTextStyle,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:60),
        child: Column(children: [
          Center(child:Text("All Bookings", style: myHeaderTextStyle)),
          allBookings(),
          
        ],),)
    );
  }
}