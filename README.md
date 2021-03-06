<img align="right" src="android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png" alt="">

# Fast Shopping

[![Build status][build-status-badge]][build-status-link]
[![Codecov][codecov-badge]][codecov-link]

[![Get it on Google Play][google-play-badge]][google-play-link]
[![Get it on F-Droid][fdroid-badge]][fdroid-link]

**Fast Shopping** is a mobile application developed with simplicity in mind. It allows you on having a simple set of shopping lists, that you can easily manage. It contains **no** ads. Targetted to everyone who wants a simple app to get the job done. Not limited to tech-savy users.

![App screenshots][app-screenshots]

## Goal

This application was made to resolve a certain problem in a certain way. 

There are many people that don't want to use a voice assistant and find other apps available on the market too overwhelming, too complex, bloated with features, bloated with ads or simply overengineered for their simple problem. In the past, you would get yourself a piece of paper and a pen and write down the stuff you need to buy, so you can read it while being in the market. **Fast shopping** is an application that does exactly that and only that. Reducing number of taps to a minimum and offering a very readable interface.

## Building

**Note:** Use Flutter `stable` channel.

```bash
git clone git@github.com:Albert221/FastShopping.git && cd FastShopping
flutter packages pub get
flutter packages pub run build_runner build
flutter build apk
# or if you want to build the debug version and run it
flutter run
```

## Translating

If you want to fix translations or add your mother tounge, contact me through email. I'll add you to the [Arbify].

Translate the app launcher name too. To do this, create a new folder in `android/app/src/main/res` called `values-<your language>` and put a `strings.xml` file there. For reference, check `android\app\src\main\res\values\strings.xml` file.

### Generate screenshots and feature graphics for stores

```bash
# Firstly open your Pixel 2 XL emulator with API 28 and then
flutter drive --target=test_driver/screenshots.dart
```

### Available languages

- English
- Polski
- Македонски ([@MatejMecka])
- Deutsch ([@kojid0], [@divadsn])
- Русский ([@rikishi0071])
- French ([@ashledombos])

[build-status-badge]: https://img.shields.io/github/workflow/status/Albert221/FastShopping/Flutter%20test
[build-status-link]: https://github.com/Albert221/FastShopping/actions?query=workflow%3A%22Flutter+test%22
[codecov-badge]: https://img.shields.io/codecov/c/gh/Albert221/FastShopping?logo=codecov
[codecov-link]: https://codecov.io/gh/Albert221/FastShopping

[google-play-badge]: assets/google-play-badge.png
[google-play-link]: https://play.google.com/store/apps/details?id=me.wolszon.fastshopping
[fdroid-badge]: assets/fdroid-badge.png
[fdroid-link]: https://www.f-droid.org/en/packages/me.wolszon.fastshopping/
[app-screenshots]: fastlane/metadata/android/en-US/images/featureGraphic.png

[Arbify]: https://github.com/Arbify/Arbify

[@matejmecka]: https://github.com/MatejMecka
[@kojid0]: https://github.com/kojid0
[@divadsn]: https://github.com/divadsn
[@rikishi0071]: https://github.com/rikishi0071
[@ashledombos]: https://github.com/ashledombos
