# 🤖 SwiFTC Library 🧑‍💻

The **ultimate** FTC data library for your Swift app.  
presented by **20240 Slingshot**

> [!NOTE]
> 🚧 This project is in early development. Please check back for more information.

> [!WARNING]
> This is the **development** branch. Please ensure you are on the right branch.

## Usage

To use SwiFTC in your project, add it as a package dependency using the Swift Package Manager.

```
https://github.com/Slingshot-20240/swiftc.git
```

## Development

### Prerequisites

In order to develop the SwiFTC library, you must have the following:

- A computer running an operating system compatible with Swift Testing. ([See table](https://github.com/swiftlang/swift-testing?tab=readme-ov-file#cross-platform-support))
- The latest Swift Toolchain

While parts of the library may be executable on non-Apple devices, compatibility with non-Apple platforms is not officially supported or maintained. This library is designed for iOS, macOS, watchOS, tvOS, and visionOS applications built with Swift.

### Project Setup

Unlike our [DECODE™ Scorer](https://github.com/Slingshot-20240/decode-scorer-ios), this library does not require code-signing, and therefore has no complicated setup. Just open it in your preferred IDE and you can go straight to coding!

To run the tests, you will need to setup configuration files. Simply remove the "Example" in the file name of each `Example******TestConfig.json` and replace their contents with your desired data and/or credentials.

For example, to use `FTCAPIV2Tests`, rename `ExampleFTCAPIV2TestConfig.json` to `FTCAPIV2TestConfig.json`, and replace the season, username, and token with your desired season and FTC API credentials:

```json
{
  "season": "INTO THE DEEP",
  "username": "example",
  "token": "BB821EB4-81DC-4B6F-B1D8-3335754414A5"
}
```

The above credentials are invalid and are for demonstration purposes only.

## Legal

### Disclaimer

*FIRST®, FIRST® Tech Challenge, FTC®, FIRST® RISE℠, SKYSTONE℠, FIRST® GAME CHANGERS℠, ULTIMATE GOAL℠, FIRST® FORWARD℠, FREIGHT FRENZY℠, FIRST® ENERGIZE℠, POWERPLAY℠, FIRST® IN SHOW℠, CENTERSTAGE℠, FIRST® DIVE℠, INTO THE DEEP℠, FIRST® AGE™, and DECODE™, are trademarks of For Inspiration and Recognition of Science and Technology (FIRST®) (www.firstinspires.org). These trademarks are used by special permission of FIRST which is not overseeing, involved with, or responsible for this activity, product, or service. © 2025 FIRST®. Used by special permission. All rights reserved.*

FTC API services: https://ftc-events.firstinspires.org/services/API

### Licenses

#### SwiFTC Library presented by 20240 Slingshot

© 2025 FTC Team 20240 Slingshot and contributors. MIT License.
