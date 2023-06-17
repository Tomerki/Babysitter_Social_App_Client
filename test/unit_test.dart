import 'package:baby_sitter/screens/register_screen.dart';
import 'package:baby_sitter/services/validation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baby_sitter/screens/login_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late loginScreenState loginScreen;
  late RegisterScreenState registerScreen;

  setUp(() {
    loginScreen = loginScreenState();
    registerScreen = RegisterScreenState();
  });

  test(
    'Initial state of login screen should be correct',
    () {
      expect(loginScreen.email, null);
      expect(loginScreen.password, null);
      expect(loginScreen.loading, false);
      expect(loginScreen.isBabysitter, false);
    },
  );

  test(
    'Initial state of register screen should be correct',
    () {
      expect(registerScreen.email, null);
      expect(registerScreen.password, null);
      expect(registerScreen.loading, false);
      expect(registerScreen.isBabysitter, false);
      expect(registerScreen.firstName, null);
      expect(registerScreen.lastName, null);
      expect(registerScreen.phoneNumber, null);
      expect(registerScreen.address, 'Pick address');
      expect(registerScreen.confirmPassword, null);
      expect(registerScreen.imageUrl, null);
      expect(registerScreen.defaultImage,
          "https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol.png");
      expect(registerScreen.userType, 'Parent');
      expect(registerScreen.selectedCountry, '');
      expect(registerScreen.favorites, []);
    },
  );

  test(
    'Email Validation',
    () {
      Map<String, bool> mails = {
        'example123@example.com': true,
        'john.doe@gmail.com': true,
        'info@company.co.uk': true,
        'user@domain': false,
        '@example.com': false,
        'jane_doe123@hotmail.com': true,
        'john!doe@gmail.com': false,
        'sales@123company.com': true,
        'user@domain@domain.com': false,
        'support@example.co.jp': true,
      };

      mails.forEach((key, value) {
        final result = !emailAddressValidator(key);
        print('Validation result for $key: $result');
        expect(result, value);
      });
    },
  );

  test(
    'Phone number Validation',
    () {
      Map<String, bool> phoneNumbers = {
        '1234567890': true,
        '9876543210': true,
        '123-456-7890': false,
        '12-3456-7890': false,
        '+1234567890': false,
        '+11234567890': false,
        '123456789': false,
        'abcdefghij': false,
      };

      phoneNumbers.forEach((key, value) {
        final result = !mobileNumberValidator(key);
        print('Validation result for $key: $result');
        expect(result, value);
      });
    },
  );
}
