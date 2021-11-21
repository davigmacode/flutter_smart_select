## [5.1.0]
* Null safety issues are fixed.
 
## [5.0.5] - 2021-10-23

* Fixes: #8 Unhandled Exception: A S2Choices<Abc?> was used after being disposed

## [5.0.2-nullsafety] - 2021-09-15

* updated docs

## [5.0.1-nullsafety] - 2021-09-14

* Static analysis warning fixed

## [5.0.0-nullsafety] - 2021-09-11

* Forked from [legacy code](https://github.com/davigmacode/flutter_smart_select.git), merged related PRs, updated with null safety. Reborn of Smart_select package

## [4.3.2] - 2020-10-09

* Prevent poping the modal when changes value is not valid
* Added default modal error message
* Configurable default confirm button

## [4.2.1] - 2020-10-09

* Fixed issue #24

## [4.2.0] - 2020-09-30

* `modalValidation` function nows should return `String` to indicates the changes value is not valid and `null` or empty `String` to indicates the changes value is valid
* `state.changes.error` to access the validation error
* To display tile with chips use param `S2Tile.body` and `S2TileChips`, instead of `S2ChipsTile`
* Add animated demo screenshot

## [4.0.1] - 2020-09-23

* edit package description, change meta import source
* example: Fixes missing MainActivity
* example: progress indicator on chips tile

## [4.0.0] - 2020-09-23

* Validate before confirm
* Auto search on type
* Accent marks handler on search
* Highlight search result
* New Chips tile widget
* Horizotal or vertical choice list scroll direction
* Use `StatefulWidget` instead of `Provider` as state management
* Configuration supports `copyWith` and `merge`
* Easy shortcut to define configuration
* Simplify class name and enum
* Removed `sticky_headers` package, provide simple API to easy implement sticky header
* Choice text and group header text highlight on filter
* Customizable choice layout and scroll direction
* Customizable every part on modal widget (header, footer, searchbar, confirm button, searchbar toggle)
* Choice select all/none, and provide an easy way to programmatic select
* New Modal barrier color and dissmisible configuration
* And many more useful configuration, please see the API documentation


## [3.0.3] - 2020-01-22

* Swap position generic type helper function for create list option from any list

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