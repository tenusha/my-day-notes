# My Day

MyDay is a mobile app developed using Flutter and Firebase. By using the app users can add daily notes and see the added notes on a list sorted by date. Also, the users have the ability to take a look at the created posts at a later time. The notes can be shared with friends as well as users can edit the notes.

MyDay app has a Google login feature and also, has a traditional sign in and log in. The users can log in from anywhere and they can view their previously added notes. Once the user signs in to the application, it will create a user account and link their notes to the account. The application has another feature swipe to edit and swipe to delete the notes in the list.

The application allows the user to edit their profile. They can change their display name and password. Google users can see their profile pictures inside the app. The application uses toast messages to display the errors to the user. Also, it has confirmation dialog boxes to verify the changes.

## Screenshots of UIs

### Welcome Screen

Once the user installed the application, the first page he/she can see is the welcome page. In there, user can select sign in or login options. If the user is already logged in, the user will be redirected directly to the Home page.

<img src="https://i.ibb.co/S7yd6c1/image.png" alt="image" border="0">

### Sign-up Page

Once the user selects the sign-up option, the app will be navigated to the sign-up screen. There are two options given for the user. Users can either use Google sign-up or the traditional sign-up by entering the user details manually.

<img src="https://i.ibb.co/Z8BX718/image.png" alt="image" border="0">

### Log-in Page

Once the user selects the log-in option, the app will be navigated to the log-in screen. There are two options given for the user. Users can either use Google log-in or by providing the username and the password.

<img src="https://i.ibb.co/bPyHCHS/image.png" alt="image" border="0">

### Google Sign-in Option

Once the user clicks Google Sign-in or Google Log-in, the app will display the list of Google accounts on the mobile. Then the user can select the preferred account to continue.

<img src="https://i.ibb.co/cJX5kDV/image.png" alt="image" border="0">

### Home Screen

Once the user successfully logged in to the application, the user can see the list of notes he/she previously added. The list is ordered by the date. The user can swipe the list Item to the right to edit the note. Also, swipe left to delete the note. A confirmation dialog will be displayed if the user needs to delete a note.

<img src="https://i.ibb.co/t2kNLRs/image.png" alt="image" border="0">

<img src="https://i.ibb.co/SXVWSyy/image.png" alt="image" border="0">

### App Bar Drawer

Users can click the menu icon in the app bar or swipe right to open the draw navigator. In there, users can select different features. Also, the user’s picture and name will be displayed. The profile picture shown in the drawer is taken from the user’s google account.

<img src="https://i.ibb.co/ckWJ3ck/image.png" alt="image" border="0">

### Add Note

Users can navigate to the “Add Note” page by clicking the “+” icon in the app bar or by selecting the option from the draw navigator. In the “Add Note” screen user needs to provide a subject to the note and the body of the note. After that by clicking the save icon in the app bar, the user can save the note.

<img src="https://i.ibb.co/bWF4szB/image.png" alt="image" border="0">

### Confirmation Dialog Box

A confirmation dialog box will be displayed when the user needs to delete an existing note.

<img src="https://i.ibb.co/KwW3YH5/image.png" alt="image" border="0">

### Edit, Share, and Delete a Note

In order to edit an existing note, user can click on top of the note in the home page, or swipe right the list item and click the edit button. Users can change the note and click the “save” icon in the app bar to save the updated note. Also, by clicking the “share” icon users can share the note as the way they expected.

<img src="https://i.ibb.co/cxmSkqW/image.png" alt="image" border="0">

### Change Account Details, Log-out

In the home screen menu, there are options to change account details and to log-out. Once user click the log-out option, the session will end and the user will be redirected to the login screen. Once user select account settings, he/she can change the display name and the password.

<img src="https://i.ibb.co/7WCyV7K/image.png" alt="image" border="0">

### Toast messages for errors.

The application uses toast messages to show validation errors to the user. A sample of toast messages can be seen at the bottom of Figure 1.8 and Figure 1.9. This toasting component is reusable and can be used from anywhere in the app.

<img src="https://i.ibb.co/4djWHCz/image.png" alt="image" border="0">

```
flutter pub get
flutter pub run flutter_launcher_icons:main -f pubspec.yaml
```
```
flutter pub get
flutter pub run flutter_launcher_icons:main
```
get SHA1 key
```
C:\Users\Name>keytool -list -v -keystore ".android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```
