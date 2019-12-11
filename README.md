# smart_select

Smart select allows you to easily convert your usual form selects to dynamic pages with grouped radio or checkbox inputs. This widget is inspired by Smart Select component from [Framework7](https://framework7.io/).

To read more about `smart_select`, see the [documentation](https://pub.dev/documentation/smart_select/latest/).

# Features

* Select single or multiple choice
* Open options in page, bottom sheet, or popup dialog
* Grouping options with sticky header
* Customizable trigger widget
* Customizable options item widget
* Customizable label, value, and group field
* Filterable option item

# Usage

## Single Choice

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
    option: SmartSelectOption(options),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Multiple Choice

```
List value = ['flutter'];
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
    option: SmartSelectOption(options),
    isMultiChoice: true,
    onChange: (val) => setState(() => value = val),
  );
}
```

## Open in Page

By default SmartSelect open options in page.

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
    option: SmartSelectOption(options),
    target: SmartSelectTarget.page,
    onChange: (val) => setState(() => value = val),
  );
}
```

## Open in Bottom Sheet

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'label': 'Ionic' },
  { 'value': 'flutter', 'label': 'Flutter' },
  { 'value': 'react', 'label': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect.sheet(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOption(options),
    onChange: (val) => setState(() => value = val),
  );
}
```

## Open in Popup Dialog

```
String value = 'flutter';
List options = [
  { 'value': 'ionic', 'label': 'Ionic' },
  { 'value': 'flutter', 'label': 'Flutter' },
  { 'value': 'react', 'label': 'React Native' },
];

@override
Widget build(BuildContext context) {
  return SmartSelect.popup(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOption(options),
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
  return SmartSelect.popup(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOption(options),
    builder: (context, state) {
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
        onTap: () => state.showOptions(context),
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
  return SmartSelect.popup(
    title: 'Frameworks',
    value: value,
    option: SmartSelectOption(
      options,
      label: 'id',
      value: 'text',
    ),
    onChange: (val) => setState(() => value = val),
  );
}
```

# Reference

| Name | Type | Description |
|------|------|-------------|
| SmartSelect | Class | General usage |
| SmartSelectTile | Class | Default trigger widget |
| SmartSelectOption | Class | Configure option |
| SmartSelectState | Class | Current state |
| SmartSelectTarget | Enum | Modal type to open option |
| SmartSelectOnChange | Typedef | Callback to handle change of value widget |
| SmartSelectBuilder | Typedef | Builder for custom trigger widget |
| SmartSelectOptionItemBuilder | Typedef | Builder for custom option item |
| SmartSelectOptionItemOnChange | Typedef | Callback to handle stats of each custom option item |
| SmartSelectOptionDividerBuilder | Typedef | Builder for custom option divider |
| SmartSelectOptionGroupHeaderBuilder | Typedef | Builder for custom option group header |
| SmartSelectOptionConfirmationBuilder | Typedef | Builder for custom confirmation widget |
| SmartSelectOptionHeaderTheme | Class | Configure option header theme |
| SmartSelectOptionItemTheme | Class | Configure option item theme |
| SmartSelectOptionGroupHeaderTheme | Class | Configure option group header theme |

# Thanks

* [Framework7](https://framework7.io/)

# TODO

* Use chip as option item
* Support dark mode

# License

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