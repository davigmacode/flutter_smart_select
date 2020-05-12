# smart_select

SmartSelect allows you to easily convert your usual form select or dropdown into dynamic page, popup dialog, or sliding bottom sheet with various choices input such as radio, checkbox, switch, chips, or even custom input. This widget is inspired by Smart Select component from [Framework7](https://framework7.io/).

# Migration from 3.0.x to 4.0.0

- Simplify class name and enum

  - `SmartSelectTile` to `S2Tile`
  - `SmartSelectOption` to `S2Choice`
  - `SmartSelectChoiceConfig` to `S2ChoiceConfig`
  - `SmartSelectChoiceStyle` to `S2ChoiceStyle`
  - `SmartSelectChoiceType` to `S2ChoiceType`
  - `SmartSelectModalConfig` to `S2ModalConfig`
  - `SmartSelectModalStyle` to `S2ModalStyle`
  - `SmartSelectModalHeaderStyle` to `S2ModalHeaderStyle`
  - `SmartSelectModalType` to `S2ModalType`

- The parameter `builder` now is a collection of builder (`S2SingleBuilder` or `S2MultiBuilder`), instead use `tileBuilder` to create trigger tile widget.

- The parameters `dense`, `enabled`, `isLoading`, `isTwoLine`, `leading`, `loadingText`, `padding`, `selected`, `trailing` is removed from `SmartSelect` class, instead use `tileBuilder` and return `S2Tile` widget, it has all these parameters.

- The parameter `onChange` nows return `S2SingleState state` or `S2MultiState state` instead of `T value` or `List<T> value`

- The parameter `choiceConfig.useWrap` is removed, instead use `choiceConfig.layout = S2ChoiceLayout.wrap`

- The parameter `choiceConfig.builder` moved to `builder.choiceBuilder`

- The parameter `choiceConfig.titleBuilder` moved to `builder.choiceTitleBuilder`

- The parameter `choiceConfig.subtitleBuilder` moved to `builder.choiceSubtitleBuilder`

- The parameter `choiceConfig.secondaryBuilder` moved to `builder.choiceSecondaryBuilder`

- The parameter `choiceConfig.dividerBuilder` moved to `builder.choiceDividerBuilder`

- The parameter `choiceConfig.emptyBuilder` moved to `builder.choiceEmptybuilder`

- The parameter `choiceConfig.glowingOverscrollIndicatorColor` is removed, instead use `choiceConfig.overscrollColor`

- The parameter `choiceConfig.spacing` and `choiceConfig.runSpacing` moved to `choiceConfig.style.spacing` and `choiceConfig.style.runSpacing`

- The parameter `choiceConfig.useCheckmark` moved to `choiceConfig.style.showCheckmark`

- The parameter `choiceConfig.padding` moved to `choiceConfig.style.wrapperPadding`

- The default of grouped choice is not using sticky header now, instead use `groupBuilder` like this:

  ```dart
  dependencies:
    sticky_headers: "^0.1.8"
  ```

  ```dart
  import 'package:sticky_headers/sticky_headers.dart';

  SmartSelect<T>.single/multiple(
    ...,
    ...,
    groupBuilder: (context, header, choices) {
      return StickyHeader(
        header: header,
        content: choices,
      );
    },
  );
  ```

# Demo

## Preview

[![Watch the demo](https://img.youtube.com/vi/bcHELDM8hWg/maxresdefault.jpg)](https://youtu.be/bcHELDM8hWg)

## Download

[![Demo App](https://github.com/davigmacode/flutter_smart_select/raw/master/example/art/qr/apk.png "Demo App")](https://github.com/davigmacode/flutter_smart_select/blob/master/example/art/demo/SmartSelect.apk?raw=true)

# Features

* Select single or multiple choice
* Open choices modal in full page, bottom sheet, or popup dialog
* Various choices input (radio, checkbox, switch, chips, or custom widget)
* Various choices layout (list, wrap, or grid)
* Grouping choices with easy support to sticky header
* Searchable choices with highlighted text
* Disabled or hidden choices
* Customizable trigger/tile widget
* Customizable modal style
* Customizable modal header style
* Customizable modal footer
* Customizable choices style
* Flexible option source type
* Async option source
* and many more

# Usage

For a complete usage, please see the [example](https://pub.dev/packages/smart_select#-example-tab-).

To read more about classes and other references used by `smart_select`, see the [API Reference](https://pub.dev/documentation/smart_select/4.0.0/).

## Single Choice

`SmartSelect<T>.single()`

```dart
String value = 'flutter';
List<S2Choice<String>> options = [
  S2Choice<String>(value: 'ion', title: 'Ionic'),
  S2Choice<String>(value: 'flu', title: 'Flutter'),
  S2Choice<String>(value: 'rea', title: 'React Native'),
];

@override
Widget build(BuildContext context) {
  return SmartSelect<String>.single(
    title: 'Frameworks',
    value: value,
    options: options,
    onChange: (state) => setState(() => value = state.value)
  );
}
```

## Multiple Choice

`SmartSelect<T>.multiple()`

```dart
List<int> value = [2];
List<S2Choice<int>> frameworks = [
  S2Choice<int>(value: 1, title: 'Ionic'),
  S2Choice<int>(value: 2, title: 'Flutter'),
  S2Choice<int>(value: 3, title: 'React Native'),
];

@override
Widget build(BuildContext context) {
  return SmartSelect<int>.multiple(
    title: 'Frameworks',
    value: value,
    options: options,
    onChange: (state) => setState(() => value = state.value),
  );
}
```

## Build Option List

`options` property is `List<S2Choice<T>>`, it can be input directly as in the example below, more info about `S2Choice` can be found on the [API Reference](https://pub.dev/documentation/smart_select/latest/smart_select/S2Choice-class.html)

```dart
SmartSelect<T>.single/multiple(
  ...,
  ...,
  options: <S2Choice<T>>[
    S2Choice<T>(value: 1, title: 'Ionic'),
    S2Choice<T>(value: 2, title: 'Flutter'),
    S2Choice<T>(value: 3, title: 'React Native'),
  ],
);
```

`options` also can be created from any list using helper provided by this package, like the example below

```dart
List<Map<String, String>> days = [
  { 'value': 'mon', 'title': 'Monday' },
  { 'value': 'tue', 'title': 'Tuesday' },
  { 'value': 'wed', 'title': 'Wednesday' },
  { 'value': 'thu', 'title': 'Thursday' },
  { 'value': 'fri', 'title': 'Friday' },
  { 'value': 'sat', 'title': 'Saturday' },
  { 'value': 'sun', 'title': 'Sunday' },
];

SmartSelect<T>.single/multiple(
  ...,
  ...,
  options: S2Choice.listFrom<T, Map<String, String>>(
    source: days,
    value: (index, item) => item['value'],
    title: (index, item) => item['title'],
  ),
);
```

## Modal Type

By default SmartSelect will open choices modal in full page. You can change it by changing the `modalType` property with this value:

```dart
SmartSelect<T>.single/multiple(
  ...,
  ...,
  // open in full page
  modalType: S2ModalType.fullPage,
  // open in popup dialog
  modalType: S2ModalType.popupDialog,
  // open in bottom sheet
  modalType: S2ModalType.bottomSheet,
);
```

## Choice Type

By default SmartSelect will use radio for single choice and checkbox for multiple choice, but it can change by changing the `choiceType` with this value:

```dart
SmartSelect<T>.single(
  ...,
  ...,
  // default use radio
  choiceType: S2ChoiceType.radios,
  // use chips
  choiceType: S2ChoiceType.chips,
);
```
```dart
SmartSelect<T>.multiple(
  ...,
  ...,
  // default use checkbox
  choiceType: S2ChoiceType.checkboxes,
  // use chips
  choiceType: S2ChoiceType.chips,
  // use switch
  choiceType: S2ChoiceType.switches,
);
```

# License

```
Copyright (c) 2019 Irfan Vigma Taufik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```