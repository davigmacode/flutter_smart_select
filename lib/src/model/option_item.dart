class SmartSelectOptionItem {
  final dynamic data;
  final dynamic value;
  final String title;
  final String subtitle;
  final String groupBy;

  SmartSelectOptionItem({
    this.data,
    this.value,
    this.title,
    this.subtitle,
    this.groupBy,
  });

  factory SmartSelectOptionItem.fromMap({
    dynamic map,
    dynamic valueProp,
    dynamic titleProp,
    dynamic subtitleProp,
    dynamic groupByProp,
  }) {
    return SmartSelectOptionItem(
      data: map,
      value: _getValFromMap(map, valueProp, 'value'),
      title: _getValFromMap(map, titleProp, 'title'),
      subtitle: _getValFromMap(map, subtitleProp),
      groupBy: _getValFromMap(map, groupByProp),
    );
  }

  factory SmartSelectOptionItem.fromList({
    dynamic list,
    dynamic valueProp,
    dynamic titleProp,
    dynamic subtitleProp,
    dynamic groupByProp,
  }) {
    return SmartSelectOptionItem(
      data: list,
      value: _getValFromList(list, valueProp, 0),
      title: _getValFromList(list, titleProp, 1),
      subtitle: _getValFromList(list, subtitleProp),
      groupBy: _getValFromList(list, groupByProp),
    );
  }

  bool contains(String query) {
    return _filterTestByTitle(query)
      || _filterTestBySubtitle(query)
      || _filterTestByGroup(query);
  }

  bool _filterTestByTitle(String query) {
    return title.toLowerCase().contains(query.toLowerCase());
  }

  bool _filterTestBySubtitle(String query) {
    return subtitle != null
      ? subtitle.toLowerCase().contains(query.toLowerCase())
      : false ;
  }

  bool _filterTestByGroup(String query) {
    return groupBy != null
      ? groupBy.toLowerCase().contains(query.toLowerCase())
      : false;
  }
}

_getValFromMap(Map data, dynamic prop, [String defaultTo]) {
  prop = prop ?? defaultTo;
  if (prop is String) {
    return _lookup(data, [prop]);
  } else if (prop is List) {
    return _lookup(data, prop);
  } else if (prop is Function) {
    return prop?.call(data);
  } else {
    return null;
  }
}

_getValFromList(List data, dynamic prop, [int defaultTo]) {
  prop = prop ?? defaultTo;
  if (prop is int) {
    return data[prop];
  } else if (prop is Function) {
    return prop?.call(data);
  } else {
    return null;
  }
}

R _lookup<R, K>(Map<K, dynamic> map, Iterable<K> keys, [R defaultTo]) {
  dynamic current = map;
  for (final key in keys) {
    current = current[key];
    if (current == null) {
      return defaultTo;
    }
  }
  return current as R;
}