import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sacny/core/error/exption.dart';

class FirebaseAuthServices {
  FirebaseAuthServices({
    required FirebaseAuth firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  static const String _googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue:
        '105266687234-cfd1iqjvpdpdrcger7uq4lncipi9ghsr.apps.googleusercontent.com',
  );

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  bool _isGoogleSignInInitialized = false;

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return _userFromCredential(credential);
    } on FirebaseAuthException catch (error) {
      throw CustomException(_messageForFirebaseAuthError(error));
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return _userFromCredential(credential);
    } on FirebaseAuthException catch (error) {
      throw CustomException(_messageForFirebaseAuthError(error));
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      await _initializeGoogleSignIn();

      if (!_googleSignIn.supportsAuthenticate()) {
        throw CustomException('Google Sign-In غير مدعوم على هذا الجهاز.');
      }

      final googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw CustomException('تعذر الحصول على رمز Google. حاول مرة أخرى.');
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      return _userFromCredential(
        await _firebaseAuth.signInWithCredential(credential),
      );
    } on CustomException {
      rethrow;
    } on GoogleSignInException catch (error) {
      throw CustomException(
        error.description ?? 'تعذر تسجيل الدخول باستخدام Google.',
      );
    } on FirebaseAuthException catch (error) {
      throw CustomException(_messageForFirebaseAuthError(error));
    }
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw CustomException('لا يوجد مستخدم مسجل حاليًا.');
    }
    await user.delete();
  }

  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  Future<void> _initializeGoogleSignIn() async {
    if (_isGoogleSignInInitialized) return;

    await _googleSignIn.initialize(serverClientId: _googleServerClientId);
    _isGoogleSignInInitialized = true;
  }

  User _userFromCredential(UserCredential credential) {
    final user = credential.user;
    if (user == null) {
      throw CustomException('تعذر العثور على بيانات المستخدم.');
    }
    return user;
  }

  String _messageForFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'weak-password':
        return 'كلمة المرور ضعيفة. استخدم 6 أحرف على الأقل.';
      case 'email-already-in-use':
        return 'يوجد حساب مسجل بهذا البريد الإلكتروني.';
      case 'invalid-email':
        return 'البريد الإلكتروني غير صحيح.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
      case 'operation-not-allowed':
        return 'فعّل تسجيل الدخول المطلوب من Firebase Authentication.';
      case 'network-request-failed':
        return 'تحقق من اتصال الإنترنت ثم حاول مرة أخرى.';
      default:
        return error.message ?? 'حدث خطأ في المصادقة. حاول مرة أخرى.';
    }
  }
}
