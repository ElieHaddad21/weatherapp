import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String selectedCity = 'Tripoli';

  // Placeholder data for weather information
  List<Map<String, dynamic>> getWeatherData(String city) {
    // Replace this with actual weather data retrieval logic
    List<String> days = ['Monday', 'Tuesday', 'Wednesday'];
    List<String> conditions = [];
    List<String> temperatures = [];

    // Generate distinct conditions and temperatures for each city
    switch (city) {
      case 'Tripoli':
        conditions = ['Sunny', 'Partly Cloudy', 'Clear'];
        temperatures = ['25°C', '20°C', '21°C'];
        break;
      case 'Batroun':
        conditions = ['Rainy', 'Thunderstorm', 'Cloudy'];
        temperatures = ['15°C', '7°C', '18°C'];
        break;
      case 'Beirut':
        conditions = ['Snowy', 'Foggy', 'Windy'];
        temperatures = ['-2°C', '7°C', '12°C'];
        break;
      default:
        conditions = ['Unknown', 'Unknown', 'Unknown'];
        temperatures = ['N/A', 'N/A', 'N/A'];
    }

    List<Map<String, dynamic>> weatherData = [];

    for (int i = 0; i < days.length; i++) {
      weatherData.add({
        'city': city,
        'day': days[i],
        'temperature': temperatures[i],
        'condition': conditions[i],
        'imageAsset': getImageAsset(conditions[i]),
      });
    }

    return weatherData;
  }

  String getImageAsset(String condition) {
    switch (condition) {
      case 'Sunny':
        return 'images/Sunny.jpg';
      case 'Partly Cloudy':
        return 'images/cloudy.jpg';
      case 'Clear':
        return 'images/clear.jpg';
      case 'Rainy':
        return 'images/Rainy.jpg';
      case 'Thunderstorm':
        return 'images/thunderstorm.jpg';
      case 'Cloudy':
        return 'images/cloudy.jpg';
      case 'Snowy':
        return 'images/snowy.jpg';
      case 'Foggy':
        return 'images/foggy.jpg';
      case 'Windy':
        return 'images/windy.jpg';
      default:
        return 'images/unknown.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> weatherData = getWeatherData(selectedCity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in Different Cities'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/s.png'),  // Replace with the actual path to your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select a City:',
                style: TextStyle(fontSize: 37, color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCity,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                    weatherData = getWeatherData(selectedCity);
                  });
                },
                style: TextStyle(fontSize: 35), // Set the font color for the selected value
                iconEnabledColor: Colors.white, // Set the font color for the dropdown button
                items: ['Tripoli', 'Batroun', 'Beirut']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value , style: TextStyle(color: Colors.blue),),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Weather in $selectedCity',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              // Weather Information Columns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  weatherData.length,
                      (index) => WeatherColumn(
                    city: weatherData[index]['city'],
                    day: weatherData[index]['day'],
                    temperature: weatherData[index]['temperature'],
                    condition: weatherData[index]['condition'],
                    imageAsset: weatherData[index]['imageAsset'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherColumn extends StatelessWidget {
  final String city;
  final String day;
  final String temperature;
  final String condition;
  final String imageAsset;

  WeatherColumn({
    required this.city,
    required this.day,
    required this.temperature,
    required this.condition,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // Adjust the width as needed
      height: 350, // Adjust the height as needed
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 45),
          Text(
            temperature,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            condition,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
