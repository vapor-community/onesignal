# OneSignal

Using OneSignal on Vapor.

For sending to an array of device tokens:

```swift
let deviceTokens = ["foo...", "bar..."]
let message = OneSignalMessage("Hello Vapor!")
let notif = OneSignalNotification(message: message, iosDeviceTokens: [deviceTokens])
let app = OneSignalApp(apiKey: Environment.get("ONESIGNAL_API_KEY") ?? "", appId: Environment.get("ONESIGNAL_APP_ID") ?? "")
let result = try OneSignal.makeService(for: request).send(notification: notif, toApp: app)
```
