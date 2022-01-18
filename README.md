# KMTX

## Usage
Add KMTXPermissions.plist like this:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>testToken</key>
    <string>Your test token</string>
    <key>token</key>
    <string>Your token</string>
</dict>
</plist>
```
Replace "Your test token" and "Your token" on your real tokens.

For UIWindowSceneDelegate:
```swift
func scene(_ scene: UIScene,
           willConnectTo session: UISceneSession,
           options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    
    KMTX.initialize(with: connectionOptions)
}

func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    KMTX.handle(userActivity.webpageURL)
}
```

For UIApplicationDelegate:
```swift
func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions
                    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    KMTX.initialize(with: launchOptions)
    return true
}

func application(_ application: UIApplication,
                 continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

    KMTX.handle(userActivity.webpageURL)
    return true
}
```
You can configure KMTX:
```swift
var config = Configurations()

config.isTest = true                    // Use test token
config.isLogging = true                 // Enable all logs
config.isSendEventsListLogging = true   // Enable events list logs
config.isReceiveEventLogging = true     // Enable events logs
config.isNetworkLogging = true          // Enable network logs

KMTX.initialize(with: launchOptions, config: config)
```
## Installation

If you have permission for this repository you can use carthage or Swift Package Manager. Also you can add KMTX like SPM manually into your project.
