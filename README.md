# SwiftEntryKit

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-Swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

SwiftEntryKit is still WIP and will be released very soon.

SwiftEntryKit is a pop-up/banner presenter library for iOS.

## Features
- **Entry Position** - Entries can be displayed at the top or the bottom of the screen.
- **Presets** - SwiftEntryKit offers various beautiful entry presets that can be themed with your app colors and fonts.
- **Entries are highly customizable**
  - Entries can have a border, drop-shadow and round corners.
  - Entries background can be blurred, colorred or a gradient style.
  - The screen background can be dimmed.
  - Entries push and pop animations the can be customized.
  - User interaction with the entry or the screen can dismiss the entry or be ignored and pass forward  to the application window.
- **Status Bar** - Status bar style can be replaced once the entry shows and gets it's previous style again when the entry animates out.
- **Haptic Feedback** - Automatically supported (with device restrictions).
- **Screen Transitions** - The entries are displayed in a designated UIWindow above the application window (The window level is customizable as well), so the user can navigate the app freely while entries are being displayed.
- **Custom Views** Supports custom views / programmatically initialized views / nib initialized views.

## Example

Taken from the Example project, here are some presets and abilities that can be used.

Toasts | Notes | Floats | Custom Message | Custom Nib
--- | --- | --- | --- | ---
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/toasts.gif) | ![demo_02](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/notes.gif) | ![demo_03](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/floats.gif) | ![demo_04](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/animated_custom.gif) | ![demo_05](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/custom_nib.gif)

The example project contains a Playground in which you can investigate preferable displays of entries.

### Playground - noun: a place where people can play :-)

The example app contains a playground screen - an interface that enable you to customize and create entries.
the playground screen has some limitations but you can easily modify the internal logic to suit your needs.


Here are some playground samples:

Screen | Top Float | Bottom Float
--- | --- | ---
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground.gif) | ![demo_02](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground_top.jpeg) | ![demo_03](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/playground_bottom.jpeg)


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9 or any higher version.
- SwiftEntryKit leans heavily on [QuickLayout](https://github.com/huri000/QuickLayout) to layout the views programmatically.
- The library has not been tested with iOS 8 or lower.

## Installation

SwiftEntryKit is still WIP and will be formally released very soon.

## Usage

### The basic types:

***EKAttributes*** - is the entry's descriptor. Each time an entry is displayed, an EKAttributes object is used to describe the entry's presentation, position inside the screen, the display duration, it's frame constraints (if needed), it's styling (corners, border and shadow), the user interaction events, the animations and more.

Below the attributes that can be set:

**Window Level** - The entry's window level

**Display Position** - The entry can be displayed either at the top or the bottom of the screen.

**Display Priority** - The display priority of the entry determines whether it can be popped by entries with lower priority.

**Display Duration** - The display duration of the entry (Counted from the moment the entry is finished it's entrance animation).

**Position Constraints** - Constraints that tie the entry tightly to the screen contexts, for example: Height, Width, Max Width, Additional Vertical Offset.

**Background Style** - The entry and the screen can have various background styles, such as blur, color, gradient and even an image.

**User Interaction** - The entry and the screen can be interacted by the user. User interaction be can intercepted in various ways, such as: dismiss the entry, be ignored, pass the touch forward to the lower level window, and more.

**Shadow** - The shadow that surrounds the entry

**Round Corners** - Round corners around the entry

**Border** - The border around the entry

**Entrance Animation** - Describes how the entry animates inside

**Exit Animation** - Describes how the entry animates out

**Pop Behavior** - Describes the entry behavior when it's being popped (gives priority to the next entry).

**Status Bar Style** - The status bar style can be modified for the display duration of the entry. In order to enable this feature you just set *View controller-based status bar appearance* to *NO* in your project's info.plist file.

**Options** - Contains additional attributes like whether a haptic feedback should be generated once the entry is displayed.


EKAttributes' interface is as follows:

```Swift
public struct EKAttributes {
    public var windowLevel: WindowLevel
    public var position: Position
    public var displayPriority: DisplayPriority
    public var displayDuration: TimeInterval
    public var positionConstraints: PositionConstraints
    public var entryBackground: BackgroundStyle
    public var screenBackground: BackgroundStyle
    public var screenInteraction: UserInteraction
    public var entryInteraction: UserInteraction
    public var shadow: Shadow
    public var roundCorners: RoundCorners
    public var border: Border
    public var entranceAnimation: Animation
    public var exitAnimation: Animation
    public var popBehavior: PopBehavior
    public var statusBarStyle: UIStatusBarStyle!
    public var options: Options
}
```

### Basic usage example:

```Swift
// Create a basic toast that appears at the top
let attributes = EKAttributes.topToast

// Set it's background to white
attributes.entryBackground = .color(color: .white)

// Animate in with 0.3s duration using translation and scale
attributes.entranceAnimation = .init(duration: 0.3, types: [.translate, .scale(from: 0.5, to: 1)])

// Animate out using translation only
attributes.exitAnimation = .translation

let customView = CustomView()
/*
... Customize the view as you like ...
*/

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: customView, using: attributes)
```

### Using SwiftEntryKit's presets - example:

```Swift
// Generate top note entry - located below the status bar.
let attributes = EKAttributes.topNote
attributes.entryBackground = .color(color: .white)

// Set dark status bar style as long as the entry shows
attributes.statusBarStyle = .default

// Set the style of the note
let text = "Doing some testing over here!"
let style = EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .black)
let labelContent = EKProperty.LabelContent(text: text, style: style)

// Create the note view
let contentView = EKNoteMessageView(with: labelContent)

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: contentView, using: attributes)
```

### How to deal with the screen Safe Area:

*EKAttributes.PositionConstraints.SafeArea* may be used to override the safe area with the entry's content, or to fill the safe area with a background color (like [Toasts](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/toasts.gif) do), or even leave the safe area empty (Like [Floats](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/floats.gif) do).

SwiftEntryKit supports iOS 11.x.y and is backward compatible with iOS 9.x.y and 10.x.y, so the status bar area is treated the same as the safe area in earlier iOS versions.

### How to deal with device orientation change:

SwiftEntryKit identifies orientation changes and adjust the entry's layout to those changes.

Therefore, if you wish to limit the entries's width, you are able to do so by giving it a maximum value, likewise:

```Swift
let attributes = EKAttributes.topFloat

// Give the entry the width of the screen minus 20pts from each side.
attributes.positionConstraints.width = .offset(value: 20)

// Give the entry maximum width of the screen minimum edge - thus the entry won't grow much when the device orientation changes from portrait to landscape mode.
let maxWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
attributes.positionConstraints.maximumWidth = .constant(value: maxWidth)

let customView = CustomView()
/*
... Customize the view as you like ...
*/

// Use class method of SwiftEntryKit to display the view using the desired attributes
SwiftEntryKit.display(entry: contentView, using: attributes)
```

Oriantation Change Demonstration |
--- |
![demo_01](https://github.com/huri000/SwiftEntryKit/blob/master/Example/Assets/orientation.gif)

## Contributing

Forks, patches and other feedback will be available once the library is formally released and registered in CocoaPods.

## Author

Daniel Huri, huri000@gmail.com

## License

SwiftEntryKit is available under the MIT license. See the LICENSE file for more info.
