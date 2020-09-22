// import 'choice_item.dart';

// typedef Future<List<S2Choice<T>>> S2ChoiceLoader<T>(
//   S2ChoiceLoaderInfo<T> info
// );

// class S2ChoiceLoaderInfo<T> {

//   /// Single select value
//   final T value;

//   /// Multiple select value
//   final List<T> values;

//   /// Search query
//   final String query;

//   // final int page;
//   // final int limit;

//   S2ChoiceLoaderInfo({
//     this.value,
//     this.values,
//     this.query,
//     // this.page,
//     // this.limit,
//   });

//   /// Creates a copy of this [S2ChoiceLoaderInfo] but with
//   /// the given fields replaced with the new values.
//   S2ChoiceLoaderInfo<T> copyWith({
//     T value,
//     List<T> values,
//     String query,
//     // int page,
//     // int limit,
//   }) {
//     return S2ChoiceLoaderInfo<T>(
//       value: value ?? this.value,
//       values: values ?? this.values,
//       query: query ?? this.query,
//       // page: page ?? this.page,
//       // limit: limit ?? this.limit,
//     );
//   }

//   /// Creates a copy of this [S2ChoiceLoaderInfo] but with
//   /// the given fields replaced with the new values.
//   S2ChoiceLoaderInfo<T> merge(S2ChoiceLoaderInfo<T> other) {
//     // if null return current object
//     if (other == null) return this;

//     return copyWith(
//       value: other.value,
//       values: other.values,
//       query: other.query,
//       // page: other.page,
//       // limit: other.limit,
//     );
//   }
// }