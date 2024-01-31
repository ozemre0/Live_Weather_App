import 'dart:convert';
import 'dart:ui';
import 'package:first_weather_app/additionalinfoitem.dart';
import 'package:first_weather_app/apikey.dart';
import 'package:first_weather_app/hourlyforecastitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override

  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getLiveWeather() async {
    print("f called");
    try {
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=$api_key"));

      final data = jsonDecode(res.body);

      if (data["cod"] != "200") {
        throw "An uxpected error acuured";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build f called");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [

          
          GestureDetector(
            onTap: () {
              print("Refresh button tapped");
              setState(() {});
            },
            child: const Icon(Icons.refresh,size:35,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getLiveWeather(),
        builder: (context, snapshot) {
          // print(snapshot);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 175,
                height: 175,
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          final data = snapshot.data!;
          final currentWeather = data["list"][0];
          final currentTemp = currentWeather["main"]["temp"]-273;
          final formattedTemp = currentTemp.toStringAsFixed(1);
          final currentSky = currentWeather["weather"][0]["main"];
          final currentHumidity = currentWeather["main"]["humidity"];
          final currentWindSpeed = currentWeather["wind"]["speed"];
          final currentPressure = currentWeather["main"]["pressure"];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text("London",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30),),
                              const SizedBox(height: 10,),
                              Text("$formattedTemp °C",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 30)),
                              Icon(
                                currentSky == "Clouds" || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.wb_sunny_rounded,
                                size: 70,
                              ),
                              Text(currentSky,
                                  style: const TextStyle(fontSize: 25)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Weather Forecast",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(height: 20),

                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 39,
                //     itemBuilder: (BuildContext context, int i) {
                //       return HourlyForecastItem(
                //         time: data["list"][i + 1]["dt_txt"].toString(),
                //         temperature:
                //             data["list"][i + 1]["main"]["temp"].toString(),
                // weatherdata: data["list"][i + 1]["weather"][0]
                //                 ["main"] ==
                //             "Clouds" ||
                //         data["list"][i + 1]["weather"][0]["main"] ==
                //             "Rain"
                //     ? Icons.cloud
                //     : Icons.wb_sunny,
                //       );
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    itemCount: 9,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data["list"][index + 1];
                      final dateString = hourlyForecast["dt_txt"];
                      DateTime dateTime =
                          DateFormat("dd-MM-yyyy HH:mm:ss").parse(dateString);
                      
                      final kelvinTemp = double.parse(hourlyForecast["main"]["temp"].toString());
                      final celsiusTemp = kelvinTemp - 273.15;

                      return HourlyForecastItem(
                        time: DateFormat("HH:mm").format(dateTime),
                        temperature: celsiusTemp.toStringAsFixed(2),
                        weatherdata: data["list"][index + 1]["weather"][0]
                                        ["main"] ==
                                    "Clouds" ||
                                data["list"][index + 1]["weather"][0]["main"] ==
                                    "Rain"
                            ? Icons.cloud
                            : Icons.wb_sunny,
                      );
                    },
                  ),
                ),

                const Text(
                  "Additional Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icondata: Icons.water_drop,
                      title: "Humidity",
                      value: "$currentHumidity",
                    ),
                    AdditionalInfoItem(
                        icondata: Icons.wind_power_sharp,
                        title: "Wind Speed",
                        value: "$currentWindSpeed"),
                    AdditionalInfoItem(
                        icondata: Icons.push_pin_sharp,
                        title: "Pressure",
                        value: "$currentPressure")
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
