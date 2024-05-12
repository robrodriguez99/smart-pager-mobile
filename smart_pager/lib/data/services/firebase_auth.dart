import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_pager/data/models/user_model.dart';
import 'package:smart_pager/data/repositories/user_repository_impl.dart';


class MyFirebaseAuth {
  static final _firebaseAuth = FirebaseAuth.instance;

  MyFirebaseAuth();

  currentUser() {
    return _firebaseAuth.currentUser;
  }

  // Future<SmartPagerUser> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     final user =
  //         await UserRepositoryImpl().getUsersById(userCredential.user!.uid);

  //     return user;
  //   } on Error catch (e) {
  //     print("signInWithEmailAndPassword $e");
  //     rethrow;
  //   }
  // }

  //sign in with google
  Future<SmartPagerUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      print("userCredential: " + userCredential.toString());
      // if it is a new user, create it
      if (userCredential.additionalUserInfo!.isNewUser) {
        final userJson = {
          'id': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
        };

        await UserRepositoryImpl()
            .createUser(SmartPagerUser.fromJson(userJson));
      }

      
      final user = await UserRepositoryImpl()
          .getUsersById(userCredential.user!.uid); 
        

      return user;
      
    } on Error catch (e) {
      print("signInWithGoogle $e");
      rethrow;
    }
  }



  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  Future<SmartPagerUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String lastName,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      

      final userJson = {
        'id': userCredential.user!.uid,
        'email': email,
        'name': name,
        'lastName': lastName,
      };

      final user = await UserRepositoryImpl()
          .createUser(SmartPagerUser.fromJson(userJson));

      return user;
    } on Error catch (e) {
      print(e);
      rethrow;
    }
  }
}
