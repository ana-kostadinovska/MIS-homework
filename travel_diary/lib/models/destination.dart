class Destination {
  final String name;
  final String city;
  final String country;
  final String location;
  final String description;
  final String imageUrl;
  final String bestTime;
  final String weather;
  final String budget;

  Destination({required this.name, required this.city, required this.country, required this.location, required this.description, required this.imageUrl, required this.bestTime, required this.weather, required this.budget,
  });
}

final List<Destination> destinations = [
  Destination(
    name: 'Eiffel Tower',
    city: 'Paris',
    country: 'France',
    location: '48.8584° N, 2.2945° E',
    description: 'An iconic symbol of France and a must-visit landmark.',
    imageUrl: 'https://th.bing.com/th/id/R.5ae0e9b082dd746485a04e13b1d6abd3?rik=WDF7ctcdCNPuQA&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2f3%2f3b%2fEiffel_Tower_Paris_01.JPG&ehk=QZMA6Wm2PWtGYOFc5i0GRdsg79rydHyyda%2flnV%2bSqjc%3d&risl=&pid=ImgRaw&r=0',
    bestTime: 'Spring and Fall',
    weather: 'Mild',
    budget: 'Moderate',
  ),
  Destination(
    name: 'Mount Fuji',
    city: 'Fujinomiya',
    country: 'Japan',
    location: '35.3606° N, 138.7274° E',
    description: 'A majestic mountain and one of Japan’s most famous symbols.',
    imageUrl: 'https://imgcp.aacdn.jp/img-a/1720/auto/global-aaj-front/article/2017/06/595048184fa06_5950474045019_1189093891.jpg',
    bestTime: 'July to September',
    weather: 'Cool',
    budget: 'Affordable',
  ),
  Destination(
    name: 'Florence Cathedral',
    city: 'Florence',
    country: 'Italy',
    location: '43.7734° N, 11.2558° E',
    description: 'A masterpiece of Renaissance architecture and a symbol of Florence.',
    imageUrl: 'https://th.bing.com/th/id/R.376172afce400e99ef9824ee5f74de15?rik=7%2fUg9ydUkvtSXw&pid=ImgRaw&r=0',
    bestTime: 'Spring and Summer',
    weather: 'Pleasant',
    budget: 'Moderate',
  ),
  Destination(
    name: 'Neuschwanstein Castle',
    city: 'Schwangau',
    country: 'Germany',
    location: '47.5576° N, 10.7498° E',
    description: 'A fairy-tale castle nestled in the Bavarian Alps.',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Castle_Neuschwanstein.jpg',
    bestTime: 'Spring to Early Fall',
    weather: 'Mild',
    budget: 'Affordable',
  ),
  Destination(
    name: 'Matterhorn',
    city: 'Zermatt',
    country: 'Switzerland',
    location: '45.9763° N, 7.6586° E',
    description: 'One of the most iconic peaks in the Alps, ideal for adventurers.',
    imageUrl: 'https://th.bing.com/th/id/OIP.eDumbIs9-6Z-9fh0etl-owHaE6?w=2126&h=1412&rs=1&pid=ImgDetMain',
    bestTime: 'Winter or Summer',
    weather: 'Cold',
    budget: 'Expensive',
  ),
  Destination(
    name: 'Anne Frank House',
    city: 'Amsterdam',
    country: 'Netherlands',
    location: '52.3752° N, 4.8830° E',
    description: 'The historic house where Anne Frank wrote her famous diary.',
    imageUrl: 'https://media.cntraveler.com/photos/55e0aedcf073f4db6484912a/master/w_1200,c_limit/anne-frank-house-cr-alamy.jpg',
    bestTime: 'Spring and Summer',
    weather: 'Mild',
    budget: 'Moderate',
  ),
];
