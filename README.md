# SDK Integration
 
> Xcode Reference Version: 10.1 - Swift 4.2  

> GeoUniq Framework Version: 1.4.2 
 
 
## Table of Contents

1. [Installation](#user-content-installation)
    1. [CocoaPods](#user-content-cocoapods)
    2. [Manual](#user-content-manual)
    3. [Previus version](#user-content-previus-version)
2. [Project settings](#user-content-project-settings)
    1. [Mobile key](#user-content-mobile-key)
    2. [Location usage keys](#user-content-location-usage-keys)
    3. [Universal framework](#user-content-location-universal-framework)
3. [Basic operations](#user-content-basic-operations)
    1. [Enable/Disable SDK](#user-content-enabledisable-the-sdk)
    2. [Handle user consent](#user-content-handle-user-consent)



## Installation

### CocoaPods

Add `pod 'GeoUniq'` to your Podfile and run `pod install`. More details [CocoaPods here](https://cocoapods.org/).

### Manual

1. Download the SDK from the [Console](https://console.geouniq.com) (drop down menu on the top-right corner)
2. Drag and Drop the file GeoUniq.framework into your xcode project in the Project Navigator (remember to check *"Copy items if needed"*).
2. Select Your-Project-Name general file in the Project Navigator:
    - Select Your-Target-Name
    - General tab -> Embedded Binaries section: add GeoUniq.framework
    - General tab -> Linked Framewroks and Libraries section: remove both of the duplicates of GeoUniq.framework
    - Build Settings tab -> Build Options section -> Always Embed Swift Standard Libraries -> set to YES

### Previus version

- For add Geouniq to Xcode 9.4.1 (Swift version 3.3) follow the [manual procedure](#user-content-manual)  



## Project settings

### Mobile key

Add the following key to Info.plist file (String value) with the corresponding value (that you obtained when added your app to your project)
```
GUMobileKey: 'your-mobile-key'
```


### Location usage keys

1. Add the following keys to Info.plist file (String value), the corresponding values will be shown to the user by iOS
```
NSLocationAlwaysAndWhenInUseUsageDescription: "We would like to access your locations"
NSLocationWhenInUseUsageDescription: "We would like to access your locations"
```


2. If your app supports iOS 10 add
```
NSLocationAlwaysUsageDescription: "We would like to access your locations"
```


3. Add the following key to Info.plist file (String value), it will be used to show a popup to the user before the provided by iOS. Only if the user accepted this first popup we request the permission to iOS.
```
GULocationPermissionNotDetermined: "We would like to ask your permission to access your locations"
```

### Universal framework
In order to give you the best development experience we provide an 'Universal Framework': a framework which works both on simulator and real device.

What you have to do is just add one line of code as described below:
1. Select Your-Target-Name
2. Build Phases tab -> add new Run Script phase after Embed Frameworks phase
3. Paste `./GeoUniq.framework/run` in the script text box (Cocoapods insallation paste:  `${PODS_ROOT}/GeoUniq.framework/run`)

## Basic operations

### Enable/Disable the SDK
To start the tracking engine call enable method. You can do that into the AppDelegate class. Once enabled, the SDK will not stop until you disable it by calling GeoUniq.sharedInstance().disable()

```swift
//Swift
/* ------ AppDelegate.swift ------ */

//importing the framework
import GeoUniq

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    GeoUniq.sharedInstance().enable()

    return true
}
```

```objc
//Objective C
/* ------ AppDelegate.m ------ */

//importing the framework
#import "GeoUniq/GeoUniq-Swift.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[GeoUniq sharedInstance] enable];

    return YES;
}
```

### Handle User consent

The ability of the SDK to track the device location does not give Geouniq the permission to collect user data.
According to [GDPR](https://ec.europa.eu/commission/priorities/justice-and-fundamental-rights/data-protection/2018-reform-eu-data-protection-rules_en) regulation, you should request the User the consent to collect location data on Geouniq platform.

> NOTE: if your app is not under GDPR regulation, you can avoid request the consent to the user and directly inform the SDK that it has the permission to collect data on Geouniq platform. This can be done as explained below in [Setting consent explicitely](#setting-the-user-consent-explicitely)

The SDK provides a simple way to handle user consent through the `GeoUniq.sharedInstance().showConsentDialogAndSet(completion: Bool)`, as shown in the example below.
When this method is called, the SDK first checks if it has already obtained the consent. If yes, it does nothing. Otherwise, it will show a dialog to the user requesting the consent to collect data on GeoUniq platform. The privacy policy can also be seen by the User.
If the User gives the consent, then the SDK will actually start sending data on GeoUniq platform. Otherwise, it will keep performing all the other automatic operations without sending any information on GeoUniq platform.

The closure  is used to inform the caller about the user choice. Note that the closure is received only if the alert has actually been shown.

```swift
//Swift

//importing the framework
import GeoUniq

...

GeoUniq.sharedInstance().showConsentDialogAndSet { (accepted) in
    // Your logic here.
    // You might exploit this callback to keep trace of the last time the alert has been shown to the user in order to avoid showing it too often
}

...
```

```objc
//Objective C

//importing the framework
#import "GeoUniq/GeoUniq-Swift.h"
 
...

[[GeoUniq sharedInstance] showConsentDialogAndSetWithCompletion:^(BOOL accepted) {
    // Your logic here.
    // You might exploit this callback to keep trace of the last time the alert has been shown to the user in order to avoid showing it too often
}];

...

```

#### Setting the user consent explicitely

The SDK also provides a method to explicitely set whether the User has given or not the consent. You can call the `GeoUniq.sharedInstance().setConsentStatus(isGranted: Bool)` to explicitely inform the SDK that it Geouniq is allowed to collect user data.
This is particularly useful in the following cases.

If your app is not under GDPR regulation, then you can call this method with the parameter `isGranted` equal to `true` to let the SDK collect data without requesting any consent to the User

If your app is under GDPR regulation, then you should provide the User a way to remove the consent from your app's settings.
If the User removes the consent, then you should inform the SDK by calling the method above with the parameter `isGranted` equal to `false`.
By doing so, the SDK will stop sending data to GeoUniq platform immediately.

#### Getting the consent status

The method `GeoUniq.sharedInstance().getConsentStatus()` allows to know status of the User consent.
This is the result of the User choise after showing it the consent alert, or the value explicitely set through the `GeoUniq.sharedInstance().setConsentStatus(isGranted: Bool)` method.


