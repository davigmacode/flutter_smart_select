## [3.0.2] - 2020-01-22

* Support disabled and hidden option
* Customizable choices wrapper padding
* Single choice chips now use checkmark by default, can be configure by `choiceConfig.useCheckmark`
* Improve documentation
* Update example

## [3.0.0] - 2020-01-22

* Breaking changes, more type safety, add more features, and simplify few properties
* Remove `isMultiChoice` property, instead use `SmartSelect<T>.single()` or `SmartSelect<T>.multiple()`
* Remove `option` property, instead use `options` property and change its value from `SmartSelectOptionConfig` to `List<SmartSelectOption<T>>`
* Remove `modal` property, instead use `modalType` to change how to open modal and `modalConfig` to configure modal header, modal style, etc
* Remove `choice` property, instead use `choiceType` to change choice widget and `choiceConfig` to configure choice style, etc
* Choice modal can have different title with trigger/tile widget by configuring `modalConfig.title`
* Choice modal can have leading and trailing widget by configuring `modalConfig.leading` and `modalConfig.trailing`

## [2.0.2] - 2019-12-25

* Upgrade Provider package to 4.0.0

## [2.0.1] - 2019-12-21

* fix bug when value is null for multiple choice
* update demo and add video preview example

## [2.0.0] - 2019-12-20

* Use Provider as state management
* Remove SmartSelect.popup and SmartSelect.sheet constructor
* Split option configuration into option, modal, and choices
* Support Chips and Switches as choices widget
* Add more configurable parameter and remove some option
* Fix some bugs

## [1.0.3] - 2019-12-12

* Change SmartSelectOptionGroupHeaderTheme titleStyle to textStyle
* Better documentation

## [1.0.2] - 2019-12-12

* Move and rename files for better documentation

## [1.0.1] - 2019-12-11

* Fully rewrite code
* Support filterable option item
* Support grouping options with sticky header
* Support stats loading
* More customizable trigger widget
* Support customize option header widget (theme or builder)
* Support customize option item widget (theme or builder)
* Support customize option item divider widget
* Support customizable label, value, and group field

## [0.1.1] - 2019-11-26

* Add values field to SmartMultiSelectBuilderInfo class
* Update default SmartMultiSelect placeholder
* Update example

## [0.1.0] - 2019-11-26

* Fixed bug return value multi select not updated from popup and bottom sheet options
* Update example
* Format documents

## [0.0.1] - 2019-11-25

* A description for people who will use that package or version.
* Add single choice select using page, popup, or bottom sheet
* Add multiple choice select using page, popup, or bottom sheet