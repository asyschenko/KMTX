# KMTX

## Integration
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
Replace "Your test token" and "Your token" on your real tokens. If you do not have any test token you can to remove "testToken" section.

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
## Configuration
You can configure KMTX:
```swift
var config = Configurations()

config.isTest = true                        // Use test token
config.isLogging = true                     // Enable all logs
config.logLevels = [                        // You can enable log levels. Empty array is default. It means available all levels
    .customEventsFetch,                     // Enable custom events fetching logs
    .handledRequests,                       // Enable custom events handled requests log
    .interceptedRequests,                   // Enable all handled requests log
    .receiveEvents,                         // Enable events logs
    .sendEventsList,                        // Enable events list logs
    .sendEventsNetwork                      // Enable network logs
]
config.isAvailableFourFingersTouch = true   // Enable debug mode, default it is 'false'. Use hold four fingers for 5 second or shake gesture
config.ignoreCarrier = true                 // If you do not want send carrier to analytics set 'true'. Default 'false'
config.ignoreAdvertiserId = true            // If you do not want send AdvertiserId to analytics set 'true'. Default 'false'
config.useStorageInDocuments = true         // If you want to save SDK data like logs, database etc. in documents set 'true'. Default 'false'
config.initializeWasAfterShowApp = true     // Set it to 'true' if you call 'KMTX.initialize(with: launchOptions)' after application show event. Default 'false'

KMTX.initialize(with: launchOptions, config: config)
```
### Client Id
If your application is authorized, then you should add a unique user id as shown below.
```swift
KMTX.set(clientId: "CLIENT_ID")
```

When the user logs out, you should reset the user id as shown below.
```swift
KMTX.resetClientId()
```

### Network data
In order for the analytics to work fully, you need to track the requests that are running in the application. You should send requests and responses to a special structure as shown below.

The first you should add permissions for handling URL requests. Add array of regular expressions for key 'handlingURLRegExes' to KMTXPermissions.plist like this:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>testToken</key>
        <string>Your test token</string>
    <key>token</key>
        <string>Your token</string>
    <key>handlingURLRegExes</key>
        <array>
            <string>https:\/\/some\.url1\.com.*</string>
            <string>https:\/\/some\.url2\.com.*</string>
            ...
            <string>https:\/\/some\.urlN\.com.*</string>
        </array>
</dict>
</plist>
```
All URLs from "https://some.url1.com" to "https://some.urlN.com" will handle. If array will be empty all URLs will be ignored. Use regular expression rules.

#### Automatic mode
If you have Alamofire you can use automatic mode. You should call 'enableAutomaticRequestsHandling' method and create Alamofire session after. Unfortunately you cannot use Alamofire or URLSession default sessions. For usage automatic mode do like this:
```swift
var config = Configurations()

KMTX.initialize(with: launchOptions, config: config)
KMTX.enableAutomaticRequestsHandling()

// Then you can create Alamofire session
let alamofireSession = Alamofire.Session()
```
#### Manual mode
In other cases you should use manual mode. You should send network data to KMTX SDK with the following methods.
For convenience, you can use a method that immediately receives data of URLSession. Like this:

```swift
var url = URL(string: "http://someurl")!
var request = URLRequest(url: url)

KMTX.manualInterceptStart(request) // Before starting task you should send request
URLSession.shared.dataTask(with: request) { data, response, error in
    if error == nil {
        // After finishing task you should send success result of request, response and result data
        KMTX.manualInterceptSuccess(request, response: response, data: data)
    }
    // Even result has been failure or success you should call method 'manualInterceptComplete' for completion task anyway
    KMTX.manualInterceptComplete(request)
}
```

#### Decoders
If you use custom data format in your API request/response body not JSON you should add custom decoder to KMTX like example:
```swift
class MyDecoder: BodyDecoder {
    func decode(_ data: Data) -> Any? {
        // Here you convert data to JSON object and return
        // ...
        // ...
        return convertedObject
    }
}

// Add to KMTX
KMTX.add(bodyDecoder: MyDecoder())
```

## Installation

If you have permission for this repository you can use carthage or Swift Package Manager. Also you can add KMTX like SPM manually into your project.
