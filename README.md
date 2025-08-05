<h1 align="center">🤖 SwiFTC Library 🧑‍💻</h1>

<p align="center">
  The ultimate FTC data library for your Swift app.
  <br />
  presented by 20240 Slingshot
</p>

> [!NOTE]
> 🚧 This project is in early development. Please check back for more information.

> [!WARNING]
> This is the **development** branch. Please ensure you are on the right branch.

## Development

### Prerequisites

In order to develop the SwiFTC library, you must have the following:

- A computer running an operating system compatible with Swift Testing. ([See table](https://github.com/swiftlang/swift-testing?tab=readme-ov-file#cross-platform-support))
- The latest Swift Toolchain

While parts of the library may be executable on non-Apple devices, compatibility with non-Apple platforms is not officially supported or maintained. This library is designed for iOS, macOS, watchOS, tvOS, and visionOS applications built with Swift.

### Project Setup

Unlike our [DECODE™ Scorer](https://github.com/Slingshot-20240/decode-scorer-ios), this library does not require code-signing, and therefore has no complicated setup. Just open it in your preferred IDE and you can go straight to coding!

To run the tests, you will need to setup configuration files. Simply remove the "Example" in the file name of each `Example******TestConfig.json` and replace their contents with your desired data and/or credentials.

For example, to use the `FTCAPITests`, rename `ExampleFTCAPITestConfig.json` to `FTCAPITestConfig.json`, and replace the season, username, and token with your desired season and FTC API credentials:

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

This library is an independent project developed by FTC Team 20240 Slingshot and open-source contributors. It is not affiliated with, endorsed by, or officially connected to *FIRST*® (For Inspiration and Recognition of Science and Technology), the *FIRST*® Tech Challenge (FTC), Qualcomm, RTX (Raytheon Technologies), or any other sponsors, partners, or affiliates of these organizations.

All names, brands, and content referenced are the intellectual property of their respective owners. Their use in this library is solely for identification purposes and does not imply endorsement.

FTC API services: https://ftc-events.firstinspires.org/services/API

### Licenses

#### Third-party Software

[kewlbear/NumPy-iOS](https://github.com/kewlbear/NumPy-iOS) ([MIT License](https://github.com/kewlbear/NumPy-iOS/blob/main/LICENSE))

[kewlbear/Python-iOS](https://github.com/kewlbear/Python-iOS) ([MIT License](https://github.com/kewlbear/Python-iOS/blob/kivy-ios/LICENSE))

[pvieito/PythonKit](https://github.com/pvieito/PythonKit) ([Apache License 2.0](https://github.com/pvieito/PythonKit/blob/master/LICENSE.txt))

#### SwiFTC Library presented by 20240 Slingshot

© 2025 FTC Team 20240 Slingshot and contributors. MIT License.
