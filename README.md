# smart_select

Smart select allows you to easily convert your usual form selects into dynamic pages with various choices input. This widget is inspired by Smart Select component from [Framework7](https://framework7.io/).

# Demo

[![Demo App](https://github.com/davigmacode/flutter_smart_select/tree/master/example/art/qr/apk.png "Demo App")](https://github.com/davigmacode/flutter_smart_select/tree/master/example/art/demo/SmartSelect.apk)

# Features

* Select single or multiple choice
* Open choices modal in full page, bottom sheet, or popup dialog
* Various choices input (radio, checkbox, switch, chips)
* Grouping choices with sticky header
* Customizable trigger widget (tile)
* Customizable modal style
* Customizable modal header style
* Customizable choices style
* Customizable option input
* Filterable option
* Async option
* and many more

# TODO

* Full support async option using Future

# Usage

For a complete usage, please see the [example](https://pub.dev/packages/smart_select#-example-tab-).

To read more about classes and other references used by `smart_select`, see the [documentation](https://pub.dev/documentation/smart_select/latest/).

## Single Choice

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'title': 'Ionic' },
  { 'value': 'flutter', 'title': 'Flutter' },
  { 'value': 'react', 'title': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOptionConfig(options),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Multiple Choice

```
List value = ['flutter'];
List options = [
  { 'value': 'ionic', 'title': 'Ionic' },
  { 'value': 'flutter', 'title': 'Flutter' },
  { 'value': 'react', 'title': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect(
    title: 'Frameworks',
    value: value,
    isMultiChoice: true,
    option: SmartSelectOptionConfig(options),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Open in Full Page

By default SmartSelect open choices modal in full page.

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'title': 'Ionic' },
  { 'value': 'flutter', 'title': 'Flutter' },
  { 'value': 'react', 'title': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOptionConfig(options),
    modal: SmartSelectModalConfig(
      type: SmartSelectModalType.fullPage,
    ),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Open in Bottom Sheet

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'title': 'Ionic' },
  { 'value': 'flutter', 'title': 'Flutter' },
  { 'value': 'react', 'title': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOptionConfig(options),
    modal: SmartSelectModalConfig(
      type: SmartSelectModalType.bottomSheet,
    ),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Open in Popup Dialog

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'title': 'Ionic' },
  { 'value': 'flutter', 'title': 'Flutter' },
  { 'value': 'react', 'title': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOptionConfig(options),
    modal: SmartSelectModalConfig(
      type: SmartSelectModalType.popupDialog,
    ),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Custom Trigger Widget

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'label': 'Ionic' },
  { 'value': 'flutter', 'label': 'Flutter' },
  { 'value': 'react', 'label': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOptionConfig(options),
    builder: (context, state, showChoices) {
      return ListTile(
        title: Text(state.title),
        subtitle: Text(
          state.valueDisplay,
          style: TextStyle(color: Colors.grey),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            '${state.valueDisplay[0]}',
            style: TextStyle(color: Colors.white)
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => showChoices(context),
      );
    },
    onChange: (val) => setState(() => value = val),
  );
}
```

## Custom Key Label and Value

```
String value = 'flutter';
List options = [
  { 'id': 'ionic', 'text': 'Ionic' },
  { 'id': 'flutter', 'text': 'Flutter' },
  { 'id': 'react', 'text': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      SmartSelect(
        title: 'Frameworks',
        value: value,
        option: SmartSelectOption(
          options,
          value: 'id',
          title: 'text',
        ),
        onChange: (val) => setState(() => value = val),
      ),
      SmartSelect(
        title: 'Frameworks',
        value: value,
        option: SmartSelectOption(
          options,
          value: (item) => item['id'],
          title: (item) => item['text'],
        ),
        onChange: (val) => setState(() => value = val),
      )
    ]
  );
}
```

# Thanks

* [Framework7](https://framework7.io/)

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