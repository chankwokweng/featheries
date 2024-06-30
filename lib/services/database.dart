import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {  
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
                  .collection("users")
                  .doc(id)
                  .set(userInfoMap);
    }

  Future <Map> getUserDetails(String id) async {
    return await FirebaseFirestore.instance
                  .collection("users")
                  .doc(id)
                  .get().then((DocumentSnapshot doc){
                    final data = doc.data() as Map<String,dynamic>;
                    return data;
                  },
                  // ignore: avoid_print
                  onError: (e) => print ("Error getUserDetails: $e "));
    }

  Future addUserBooking(Map<String, dynamic> bookingInfoMap) async {
    // return await FirebaseFirestore.instance
    //               .collection("Service/${bookingInfoMap["Service"]}/Bookings")
    //               .add(bookingInfoMap);

    return await FirebaseFirestore.instance
                  .collection("Bookings")
                  .add(bookingInfoMap);
    }

  Future <Stream<QuerySnapshot>> getBookings() async {
    return FirebaseFirestore.instance.collection("Bookings").snapshots();
  }

  Future deleteUserBooking(bookingId) async {
    return await FirebaseFirestore.instance
                  .collection("Bookings")
                  .doc(bookingId)
                  .delete();
  }
}