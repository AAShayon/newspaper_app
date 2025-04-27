import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:newspaper_app/app/feature/auth/data/datasources/auth_remote_datasource.dart';

// Mock classes for Firebase Auth and Google Sign-In
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}
class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockFirebaseAuth mockAuth;
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    // Initialize mocks before each test
    mockAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    dataSource = AuthRemoteDataSourceImpl(mockAuth, mockGoogleSignIn);
  });

  group('signInWithGoogle', () {
    test('should throw an exception if Google Sign-In fails', () async {
      // Arrange
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      // Act & Assert
      expect(() => dataSource.signInWithGoogle(), throwsA(isA<Exception>()));
    });

    test('should complete successfully if Google Sign-In succeeds', () async {
      // Arrange
      final mockGoogleSignInAccount = MockGoogleSignInAccount();
      final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();

      when(mockGoogleSignIn.signIn())
          .thenAnswer((_) async => mockGoogleSignInAccount);
      when(mockGoogleSignInAccount.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);
      when(mockGoogleSignInAuthentication.accessToken).thenReturn('access_token');
      when(mockGoogleSignInAuthentication.idToken).thenReturn('id_token');
      // when(mockAuth.signInWithCredential(captureAny)).thenAnswer((_) async => MockUserCredential());

      // Act
      await dataSource.signInWithGoogle();

      // Assert
      verify(mockGoogleSignIn.signIn()).called(1);
      // verify(mockAuth.signInWithCredential(argThat(isA<AuthCredential>()))).called(1);
    });
  });
}