# iBanner
iBanner is a customizable and lightweight library that makes the task of displaying in app notification banners in iOS

## Highly customizable

| Basic Banners | Banners with different types |
| ------------- | ------------- |
| ![Basic Banners](Example/gifs/basic.gif)  | ![Banners with Types](Example/gifs/types.gif)  | 

| Growing Banners | Custom Banners |
| ------------- | ------------- |
| ![Growing Banners](Example/gifs/growing.gif)  | ![Custom Banners](Example/gifs/custom.gif) | 

## Features
- Highly customizable ✅
- iPhone, iPhoneX, & iPad Support ✅
- Orientation change support ✅
- Custom `UIView` support ✅
- Support for long titles/ subtitles ✅
- Auto dismiss support ✅

## Requirements
 - iOS 11.0+
 - Xcode 11.0+
 
## Installation

### CocoaPods

iBanner is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iBanner'
```

## Usage
To create a regular banner and show it, simply:

```swift
presentBanner(message: message)
```

To show a custom banner and to add any view into banner simply:
```swift
presentBanner(message: message) { banner in
    //Load view from nib or create programmatically
    guard let view = Bundle.main.loadNibNamed("CustomBanner", owner: self, options: nil)?.first as? UIView else { return }
    banner.setContent(view)
}
```

To show different types of banner like:
- info
- warning
- error
- success

just need to update banner type in BannerConfigurations
```swift
BannerConfiguration.shared.bannerType = .info
BannerConfiguration.shared.bannerType = .warning
BannerConfiguration.shared.bannerType = .danger
BannerConfiguration.shared.bannerType = .success
```
To auto dismiss and dismiss delay simply:
```swift
BannerConfiguration.shared.autoDismiss = true
BannerConfiguration.shared.dismissDelay = 3.0
```
