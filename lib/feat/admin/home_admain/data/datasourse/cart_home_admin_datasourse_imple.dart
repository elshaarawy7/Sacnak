import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/home_admain/data/datasourse/cart_home_admin_datasourse.dart';
import 'package:sacny/feat/admin/home_admain/data/model/cart_home_model_admain.dart'; 

class CartHomeAdminDataSourceImple extends CartHomeAdminDataSource { 

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CartHomeAdminDataSourceImple();
  @override
  Future<Either<Fuiler, List<CartHomeModelAdmain>>> getProperties() async {
     try { 
      final snapshot = await FirebaseFirestore.instance.collection('property').get();
  return Right(
    snapshot.docs
        .map((doc) => CartHomeModelAdmain.fromJson(doc.data(), id: doc.id))
        .toList(),
  );
      
     } catch (e) {
       return Left(ServerFuiler(e.toString().replaceAll("Exception: ", "")));
     }
   
  }
} 