# OneSignal

Using OneSignal on Vapor.

For sending to an array of device tokens:

```swift
let apiKey = "YourApiKey"
let appId = "YourAppId"

let deviceTokens = ["foo...", "bar..."]
let message = OneSignalMessage("Hello Vapor!")
let notif = OneSignalNotification(message: message, users: deviceTokens)
let app = OneSignalApp(apiKey: apiKey, appId: appId)

let resultFuture = try OneSignal().send(notification: notif, toApp: app)
```
