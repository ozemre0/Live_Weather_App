import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {  
  const HourlyForecastItem({super.key,
   required this.time, required this.temperature, required this.weatherdata 
  });
  final String time;
  final String temperature;
  final IconData weatherdata;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(time, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Icon(
                  weatherdata,
                  size: 35,
                ),
                Text("$temperature",style: TextStyle(fontSize: 20),)
              ],
            ),
          )),
    );
  }
}

