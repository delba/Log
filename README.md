<h1 align="center">Log</h1>

<p align="center">
    <a href="https://travis-ci.org/delba/Log"><img alt="Travis Status" src="https://img.shields.io/travis/delba/Log.svg"/></a>
    <a href="https://img.shields.io/cocoapods/v/Log.svg"><img alt="CocoaPods compatible" src="https://img.shields.io/cocoapods/v/Log.svg"/></a>
    <a href="https://github.com/Carthage/Carthage"><img alt="Carthage compatible" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"/></a>
<a href="https://codebeat.co/projects/github-com-delba-log"><img alt="codebeat badge" src="https://codebeat.co/badges/cc7d96b9-2939-4b84-8dc7-0f55a31ab537" /></a> 
</p> 
`Log` is a powerful logging tool that provides built-in themes and formatters, and a nice API to define your owns.

> Get the most out of `Log` by installing [`XcodeColors`](https://github.com/robbiehanson/XcodeColors) and [`KZLinkedConsole`](https://github.com/krzysztofzablocki/KZLinkedConsole)

### Usage

#### The basics

- Use `Log` just as you would use `print`.

```swift
Log.trace("Called!!!")
Log.debug("Who is self:", self)
Log.info(some, objects, here)
Log.warning(one, two, three, separator: " - ")
Log.error(error, terminator: "😱😱😱\n")
```

<img src="https://raw.githubusercontent.com/delba/Log/assets/a.png">

- Disable `Log` by setting `enabled` to `false`:

```swift
Log.enabled = false
```

- Define a minimum level of severity to only print the messages with a greater or equal severity:

```swift
Log.minLevel = .Warning
```

> The severity levels are `Trace`, `Debug`, `Info`, `Warning`, and `Error`.

#### Customization

- Create your own `Logger` by changing its `Theme` and/or `Formatter`.

A suggested way of doing it is by extending `Formatters` and `Themes`:

```swift
extension Formatters {
    static let Detailed = Formatter("[%@] %@.%@:%@ %@: %@", [
        .Date("yyyy-MM-dd HH:mm:ss.SSS"),
        .File(fullPath: false, fileExtension: false),
        .Function,
        .Line,
        .Level,
        .Message
    ])
}

extension Themes {
    static let TomorrowNight = Theme(
        trace:   "#C5C8C6",
        debug:   "#81A2BE",
        info:    "#B5BD68",
        warning: "#F0C674",
        error:   "#CC6666"
    )
}
```

```swift
Log.formatter = .Detailed
Log.theme = .TomorrowNight
```

<img src="https://raw.githubusercontent.com/delba/Log/assets/b.png">

> See the built-in [formatters](https://github.com/delba/Log/blob/master/Source/Extensions/Formatters.swift) and [themes](https://github.com/delba/Log/blob/master/Source/Extensions/Themes.swift) for more examples.

**Tip:** `Log.format` and `Log.colors` can be useful to visually debug your logger.

- Turn off the colors by setting the theme to `nil`:

```swift
Log.theme = nil
```

#### Misc

- Define as many loggers as you want: 

```swift
let Basic = Logger(formatter: .Default)
let Short = Logger(
    formatter: Formatter("%@: %@", .Level, .Message),
    theme:     .TomorrowNightEighties,
    minLevel:  .Info
)
```

<img src="https://raw.githubusercontent.com/delba/Log/assets/c.png">

- Include a custom `Block` component in your formatter to print its result in every log message: 

```swift
struct User {
    static func token() -> Int {
        return NSUserDefaults.standardUserDefaults.integerForKey("token")
    }
}

Log.formatter = Formatter("[%@] %@: %@", .Block(User.token), .Level, .Message)
```

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Log into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "delba/Log"
```

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Log into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'Log'
```

## License

Copyright (c) 2015 Damien (http://delba.io)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
