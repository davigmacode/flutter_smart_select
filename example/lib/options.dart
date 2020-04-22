import 'package:smart_select/smart_select.dart' show S2Option;

List<S2Option<String>> days = [
  S2Option<String>(value: 'mon', title: 'Monday'),
  S2Option<String>(value: 'tue', title: 'Tuesday'),
  S2Option<String>(value: 'wed', title: 'Wednesday'),
  S2Option<String>(value: 'thu', title: 'Thursday'),
  S2Option<String>(value: 'fri', title: 'Friday'),
  S2Option<String>(value: 'sat', title: 'Saturday'),
  S2Option<String>(value: 'sun', title: 'Sunday'),
];

List<S2Option<String>> months = [
  S2Option<String>(value: 'jan', title: 'January'),
  S2Option<String>(value: 'feb', title: 'February'),
  S2Option<String>(value: 'mar', title: 'March'),
  S2Option<String>(value: 'apr', title: 'April'),
  S2Option<String>(value: 'may', title: 'May'),
  S2Option<String>(value: 'jun', title: 'June'),
  S2Option<String>(value: 'jul', title: 'July'),
  S2Option<String>(value: 'aug', title: 'August'),
  S2Option<String>(value: 'sep', title: 'September'),
  S2Option<String>(value: 'oct', title: 'October'),
  S2Option<String>(value: 'nov', title: 'November'),
  S2Option<String>(value: 'dec', title: 'December'),
];

List<S2Option<String>> os = [
  S2Option<String>(value: 'and', title: 'Android'),
  S2Option<String>(value: 'ios', title: 'IOS'),
  S2Option<String>(value: 'mac', title: 'Macintos'),
  S2Option<String>(value: 'tux', title: 'Linux'),
  S2Option<String>(value: 'win', title: 'Windows'),
];

List<S2Option<String>> heroes = [
  S2Option<String>(value: 'bat', title: 'Batman'),
  S2Option<String>(value: 'sup', title: 'Superman'),
  S2Option<String>(value: 'hul', title: 'Hulk'),
  S2Option<String>(value: 'spi', title: 'Spiderman'),
  S2Option<String>(value: 'iro', title: 'Ironman'),
  S2Option<String>(value: 'won', title: 'Wonder Woman'),
];

List<S2Option<String>> fruits = [
  S2Option<String>(value: 'app', title: 'Apple'),
  S2Option<String>(value: 'ore', title: 'Orange'),
  S2Option<String>(value: 'mel', title: 'Melon'),
];

List<S2Option<String>> frameworks = [
  S2Option<String>(value: 'ion', title: 'Ionic'),
  S2Option<String>(value: 'flu', title: 'Flutter'),
  S2Option<String>(value: 'rea', title: 'React Native'),
];

List<S2Option<String>> categories = [
  S2Option<String>(value: 'ele', title: 'Electronics'),
  S2Option<String>(value: 'aud', title: 'Audio & Video'),
  S2Option<String>(value: 'acc', title: 'Accessories'),
  S2Option<String>(value: 'ind', title: 'Industrial'),
  S2Option<String>(value: 'wat', title: 'Smartwatch'),
  S2Option<String>(value: 'sci', title: 'Scientific'),
  S2Option<String>(value: 'mea', title: 'Measurement'),
  S2Option<String>(value: 'pho', title: 'Smartphone'),
];

List<S2Option<String>> sorts = [
  S2Option<String>(value: 'popular', title: 'Popular'),
  S2Option<String>(value: 'review', title: 'Most Reviews'),
  S2Option<String>(value: 'latest', title: 'Newest'),
  S2Option<String>(value: 'cheaper', title: 'Low Price'),
  S2Option<String>(value: 'pricey', title: 'High Price'),
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

List<Map<String,dynamic>> transports = [
  {
    'title': 'Premium',
    'subtitle': 'Premium cars for superior experience',
    'image': 'https://source.unsplash.com/oUBjd22gF6w/100x100',
  },
  {
    'title': 'Business',
    'subtitle': 'Executive cars with added comfort',
    'image': 'https://source.unsplash.com/3ZUsNJhi_Ik/100x100',
  },
  {
    'title': 'Go',
    'subtitle': 'Executive cars with added comfort',
    'image': 'https://source.unsplash.com/p7tai9P7H-s/100x100',
  },
  {
    'title': 'Mini',
    'subtitle': 'Executive cars with added comfort',
    'image': 'https://source.unsplash.com/doli0TqGBac/100x100',
  },
  {
    'title': 'Bike',
    'subtitle': 'Executive cars with added comfort',
    'image': 'https://source.unsplash.com/2LTMNCN4nEg/100x100',
  },
];