
# Apiro Auth

This plugin allows Flutter apps to add autentication screens with various flags for social auth buttons.

This plugin works Android, ios and web.

Any updates and suggestions are most welcome.


## :sparkles: What's New
#### Version 1.0.0 (29th Jun 2021)

-- Change location of register button

## :book: Guide

#### 1. Setup the config file

Add your Apiro Table configuration to your `pubspec.yaml`.
An example is shown below. 
```yaml
dependencies:
  user_authentication:
    git:
      url: https://github.com/redapiro/apiro_flutter_auth.git
```

```
  flutter pub get
```

## Usage

### Parameters 
1. isLoginWithApiroVisible - Flag for testing purpose login is available
2. isGoogleLoginAvailable - Flag for google login is available
3. isMicrosoftLoginAvailable - Flag for microsoft login is available  
4. onMicroSoftSignInClick - Callback on microsoft signin
5. onGoogleSignInClick - Callback on Google Login 
6. onLoginWithApiroClick - callback on apiro login click
7. onLogin - on login callback
8. onSignUp - on sign up button click callback

![Untitled](https://user-images.githubusercontent.com/70631810/124587887-cb670b80-de75-11eb-9434-55c60e7e4817.png)


```dart
  import 'package:user_authentication/user_authentication.dart';
  
  AuthenticationScreen(
  //test login button flag
          isLoginWithApiroVisible: GlobalConfig.LOGIN_WITH_APIRO_VISIBLE,
          //google login button flag
          isGoogleLoginAvailable: true,
          //microsoft login button flag
          isMicrosoftLoginAvailable: true,
          //microsoft login completer to show loader
          onMicroSoftSignInClick: (completer) {
            this._onLoginWithMicroSoftClick(completer);
          },
          //google login completer to show loader
          onGoogleSignInClick: (completer) {
            _onSignInWithGoogleClick(completer);
          },
          // login with apiro completer to show loader
          onLoginWithApiroClick: (completer) {
            _onLoginWithApiroClick(completer);
          },
          //microsoft login completer to show loader
          onForgotPassword: (email, completer) {
            _onForgotPasswordSubmit(email, completer);
          },
          // login completer to show loader with login data
          onLogin: (data, completer) {
            _onLoginSubmit(data, completer);
          },
          // singup completer to show loader with login data
          onSignUp: (data, completer) {
            _onSignUpSubmit(data, completer);
          },
        ))



```

## Note: -

Please add assets in following folders for logo and social login images - 

assets/images/google.png

assets/images/logo.png

assets/images/microsoft.png

This plugin will fetch the images from these locations

#### For social logins all related configurations will be done at client side (i.e. Google login client id and secret configuration)


For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
