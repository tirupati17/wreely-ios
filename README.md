[![Codacy Badge](https://api.codacy.com/project/badge/Grade/27d93a9876ff46a981eb75478e454f5b)](https://www.codacy.com?utm_source=github.com&utm_medium=referral&utm_content=tirupati17/wreely-social-iphone&utm_campaign=Badge_Grade_Dashboard)

# Wreely - Social iOS
Wreely - Social is a community platform iOS app linked with the [Wreely - Workspace Management Platform](http://wreely.com). This app aims to engage workspace co-workers, allowing interactions and access to various workspace-related activities and information.

## Features
- **Explore Feeds:** View the latest feeds from the member wall section.
- **Member/Company Details:** Access details of members or companies in your workspace.
- **Group Chat:** Initiate group chats within your workspace.
- **Meeting Room Bookings:** Book available meeting rooms in the workspace.
- **Community Interaction:** Interact with the community through comments under each post of the member wall.
- **Event Information:** Stay informed about the latest events organized by your workspace.

## Screenshots

<img src="https://github.com/tirupati17/wreely-android/blob/b734188b406b2437f0dc7d534ef020651eb1fb35/screenshot/1.jpg?raw=true"  width="20%" height="20%"> <img src="https://github.com/tirupati17/wreely-android/blob/b734188b406b2437f0dc7d534ef020651eb1fb35/screenshot/2.jpg?raw=true"  width="20%" height="20%">
<img src="https://github.com/tirupati17/wreely-android/blob/b734188b406b2437f0dc7d534ef020651eb1fb35/screenshot/3.jpg?raw=true"  width="20%" height="20%">
<img src="https://github.com/tirupati17/wreely-android/blob/b734188b406b2437f0dc7d534ef020651eb1fb35/screenshot/4.jpg?raw=true"  width="20%" height="20%">

## Initial Setup and Dependencies
Wreely - Social is developed using Swift and integrates with [Firebase](https://firebase.google.com/docs/ios/setup). The dependencies are managed using [CocoaPods](https://cocoapods.org/). To set up the project, install the pods and open the .xcworkspace file in Xcode.

```shell
$ pod install
$ open WreelySocial.xcworkspace
```

## Firebase Project Creation
1. Create a new project in the [Firebase Console](https://firebase.google.com/console).
2. To add Wreely - Social to your Firebase project, use the bundle ID `com.celerstudio.wreelysocial`.
3. Download the `GoogleService-Info.plist` file and copy it to the root directory of the app.

### Google Sign-In Setup
1. Navigate to your project in the [Firebase Console](https://console.firebase.google.com).
2. Select the **Auth** panel, go to the **Sign In Method** tab, and enable **Email/Password**. Click **Save**.
3. Open your `Info.plist`, navigate to `URL types > Item 0 > URL schemes`, and replace the `YOUR_REVERSED_CLIENT_ID` with the `REVERSED_CLIENT_ID` value from `GoogleService-Info.plist`.

## Running the App
- Run the app on your device or a simulator and sign in with the credentials provided by your workspace.

## Disclaimer

Please note that this codebase is not actively maintained. The code is old and might not run as expected due to changes in dependencies and the Swift programming language. It is being open-sourced as-is for educational purposes, and any updates to make it functional on current iOS versions are welcome.
