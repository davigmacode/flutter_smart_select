import 'package:flutter/foundation.dart';
import 'group_data.dart';

/// Comparator function to use in [List.sort]
typedef int S2SortComparator<E>(E a, E b);

/// Comparator function to sort the choice group enhanced with predefined function
@immutable
class S2GroupSort with Diagnosticable {
  /// Comparator function to sort the group
  final S2SortComparator<S2Group> compare;

  /// Default constructor
  S2GroupSort(this.compare);

  /// Function to sort the group keys alphabetically by name in ascending order
  factory S2GroupSort.byNameInAsc() => S2GroupSort((S2Group a, S2Group b) {
        return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
      });

  /// Function to sort the group keys alphabetically by name in descending order
  factory S2GroupSort.byNameInDesc() => S2GroupSort((S2Group a, S2Group b) {
        return b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
      });

  /// Function to sort the group keys by items count in ascending order
  factory S2GroupSort.byCountInAsc() => S2GroupSort((S2Group a, S2Group b) {
        return a.count.compareTo(b.count);
      });

  /// Function to sort the group keys by items count in descending order
  factory S2GroupSort.byCountInDesc() => S2GroupSort((S2Group a, S2Group b) {
        return b.count.compareTo(a.count);
      });
}
