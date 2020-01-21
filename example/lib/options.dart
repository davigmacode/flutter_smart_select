import 'package:smart_select/smart_select.dart' show SmartSelectOption;

List<SmartSelectOption<String>> days = [
  SmartSelectOption<String>(value: 'mon', title: 'Monday'),
  SmartSelectOption<String>(value: 'tue', title: 'Tuesday'),
  SmartSelectOption<String>(value: 'wed', title: 'Wednesday'),
  SmartSelectOption<String>(value: 'thu', title: 'Thursday'),
  SmartSelectOption<String>(value: 'fri', title: 'Friday'),
  SmartSelectOption<String>(value: 'sat', title: 'Saturday'),
  SmartSelectOption<String>(value: 'sun', title: 'Sunday'),
];

List<SmartSelectOption<String>> months = [
  SmartSelectOption<String>(value: 'jan', title: 'January'),
  SmartSelectOption<String>(value: 'feb', title: 'February'),
  SmartSelectOption<String>(value: 'mar', title: 'March'),
  SmartSelectOption<String>(value: 'apr', title: 'April'),
  SmartSelectOption<String>(value: 'may', title: 'May'),
  SmartSelectOption<String>(value: 'jun', title: 'June'),
  SmartSelectOption<String>(value: 'jul', title: 'July'),
  SmartSelectOption<String>(value: 'aug', title: 'August'),
  SmartSelectOption<String>(value: 'sep', title: 'September'),
  SmartSelectOption<String>(value: 'oct', title: 'October'),
  SmartSelectOption<String>(value: 'nov', title: 'November'),
  SmartSelectOption<String>(value: 'dec', title: 'December'),
];

List<SmartSelectOption<String>> os = [
  SmartSelectOption<String>(value: 'and', title: 'Android'),
  SmartSelectOption<String>(value: 'ios', title: 'IOS'),
  SmartSelectOption<String>(value: 'mac', title: 'Macintos'),
  SmartSelectOption<String>(value: 'tux', title: 'Linux'),
  SmartSelectOption<String>(value: 'win', title: 'Windows'),
];

List<SmartSelectOption<String>> heroes = [
  SmartSelectOption<String>(value: 'bat', title: 'Batman'),
  SmartSelectOption<String>(value: 'sup', title: 'Superman'),
  SmartSelectOption<String>(value: 'hul', title: 'Hulk'),
  SmartSelectOption<String>(value: 'spi', title: 'Spiderman'),
  SmartSelectOption<String>(value: 'iro', title: 'Ironman'),
  SmartSelectOption<String>(value: 'won', title: 'Wonder Woman'),
];

List<SmartSelectOption<String>> fruits = [
  SmartSelectOption<String>(value: 'app', title: 'Apple'),
  SmartSelectOption<String>(value: 'ore', title: 'Orange'),
  SmartSelectOption<String>(value: 'mel', title: 'Melon'),
];

List<SmartSelectOption<String>> frameworks = [
  SmartSelectOption<String>(value: 'ion', title: 'Ionic'),
  SmartSelectOption<String>(value: 'flu', title: 'Flutter'),
  SmartSelectOption<String>(value: 'rea', title: 'React Native'),
];

List<SmartSelectOption<String>> categories = [
  SmartSelectOption<String>(value: 'ele', title: 'Electronics'),
  SmartSelectOption<String>(value: 'aud', title: 'Audio & Video'),
  SmartSelectOption<String>(value: 'acc', title: 'Accessories'),
  SmartSelectOption<String>(value: 'ind', title: 'Industrial'),
  SmartSelectOption<String>(value: 'wat', title: 'Smartwatch'),
  SmartSelectOption<String>(value: 'sci', title: 'Scientific'),
  SmartSelectOption<String>(value: 'mea', title: 'Measurement'),
  SmartSelectOption<String>(value: 'pho', title: 'Smartphone'),
];

List<SmartSelectOption<String>> sorts = [
  SmartSelectOption<String>(value: 'popular', title: 'Popular'),
  SmartSelectOption<String>(value: 'review', title: 'Most Reviews'),
  SmartSelectOption<String>(value: 'latest', title: 'Newest'),
  SmartSelectOption<String>(value: 'cheaper', title: 'Low Price'),
  SmartSelectOption<String>(value: 'pricey', title: 'High Price'),
];

List<Map<String,dynamic>> cars = [
  { 'value': 'bmw-x1', 'title': 'BMW X1', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'bmw-x7', 'title': 'BMW X7', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'bmw-x2', 'title': 'BMW X2', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'bmw-x4', 'title': 'BMW X4', 'brand': 'BMW', 'body': 'SUV' },
  { 'value': 'honda-crv', 'title': 'Honda C-RV', 'brand': 'Honda', 'body': 'SUV' },
  { 'value': 'honda-hrv', 'title': 'Honda H-RV', 'brand': 'Honda', 'body': 'SUV' },
  { 'value': 'mercedes-gcl', 'title': 'Mercedes-Benz G-class', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'mercedes-gle', 'title': 'Mercedes-Benz GLE', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'mercedes-ecq', 'title': 'Mercedes-Benz ECQ', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'mercedes-glcc', 'title': 'Mercedes-Benz GLC Coupe', 'brand': 'Mercedes', 'body': 'SUV' },
  { 'value': 'lr-ds', 'title': 'Land Rover Discovery Sport', 'brand': 'Land Rover', 'body': 'SUV' },
  { 'value': 'lr-rre', 'title': 'Land Rover Range Rover Evoque', 'brand': 'Land Rover', 'body': 'SUV' },
  { 'value': 'honda-jazz', 'title': 'Honda Jazz', 'brand': 'Honda', 'body': 'Hatchback' },
  { 'value': 'honda-civic', 'title': 'Honda Civic', 'brand': 'Honda', 'body': 'Hatchback' },
  { 'value': 'mercedes-ac', 'title': 'Mercedes-Benz A-class', 'brand': 'Mercedes', 'body': 'Hatchback' },
  { 'value': 'hyundai-i30f', 'title': 'Hyundai i30 Fastback', 'brand': 'Hyundai', 'body': 'Hatchback' },
  { 'value': 'hyundai-kona', 'title': 'Hyundai Kona Electric', 'brand': 'Hyundai', 'body': 'Hatchback' },
  { 'value': 'hyundai-i10', 'title': 'Hyundai i10', 'brand': 'Hyundai', 'body': 'Hatchback' },
  { 'value': 'bmw-i3', 'title': 'BMW i3', 'brand': 'BMW', 'body': 'Hatchback' },
  { 'value': 'bmw-sgc', 'title': 'BMW 4-serie Gran Coupe', 'brand': 'BMW', 'body': 'Hatchback' },
  { 'value': 'bmw-sgt', 'title': 'BMW 6-serie GT', 'brand': 'BMW', 'body': 'Hatchback' },
  { 'value': 'audi-a5s', 'title': 'Audi A5 Sportback', 'brand': 'Audi', 'body': 'Hatchback' },
  { 'value': 'audi-rs3s', 'title': 'Audi RS3 Sportback', 'brand': 'Audi', 'body': 'Hatchback' },
  { 'value': 'audi-ttc', 'title': 'Audi TT Coupe', 'brand': 'Audi', 'body': 'Coupe' },
  { 'value': 'audi-r8c', 'title': 'Audi R8 Coupe', 'brand': 'Audi', 'body': 'Coupe' },
  { 'value': 'mclaren-570gt', 'title': 'Mclaren 570GT', 'brand': 'Mclaren', 'body': 'Coupe' },
  { 'value': 'mclaren-570s', 'title': 'Mclaren 570S Spider', 'brand': 'Mclaren', 'body': 'Coupe' },
  { 'value': 'mclaren-720s', 'title': 'Mclaren 720S', 'brand': 'Mclaren', 'body': 'Coupe' },
];

List<Map<String,dynamic>> smartphones = [
  { 'id': 'sk3', 'name': 'Samsung Keystone 3', 'brand': 'Samsung', 'category': 'Budget Phone' },
  { 'id': 'n106', 'name': 'Nokia 106', 'brand': 'Nokia', 'category': 'Budget Phone' },
  { 'id': 'n150', 'name': 'Nokia 150', 'brand': 'Nokia', 'category': 'Budget Phone' },
  { 'id': 'r7a', 'name': 'Redmi 7A', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'ga10s', 'name': 'Galaxy A10s', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'rn7', 'name': 'Redmi Note 7', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'ga20s', 'name': 'Galaxy A20s', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'mc9', 'name': 'Meizu C9', 'brand': 'Meizu', 'category': 'Mid End Phone' },
  { 'id': 'm6', 'name': 'Meizu M6', 'brand': 'Meizu', 'category': 'Mid End Phone' },
  { 'id': 'ga2c', 'name': 'Galaxy A2 Core', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'r6a', 'name': 'Redmi 6A', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'r5p', 'name': 'Redmi 5 Plus', 'brand': 'Xiaomi', 'category': 'Mid End Phone' },
  { 'id': 'ga70', 'name': 'Galaxy A70', 'brand': 'Samsung', 'category': 'Mid End Phone' },
  { 'id': 'ai11', 'name': 'iPhone 11 Pro', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'aixr', 'name': 'iPhone XR', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'aixs', 'name': 'iPhone XS', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'aixsm', 'name': 'iPhone XS Max', 'brand': 'Apple', 'category': 'Flagship Phone' },
  { 'id': 'hp30', 'name': 'Huawei P30 Pro', 'brand': 'Huawei', 'category': 'Flagship Phone' },
  { 'id': 'ofx', 'name': 'Oppo Find X', 'brand': 'Oppo', 'category': 'Flagship Phone' },
  { 'id': 'gs10', 'name': 'Galaxy S10+', 'brand': 'Samsung', 'category': 'Flagship Phone' },
];