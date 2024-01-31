import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({super.key, 
    required this.icondata,
    required this.title,
    required this.value,
  });
  final IconData icondata;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      children: [
                        Icon(icondata,size: 45,),
                        const SizedBox(height: 8,),
                        Text(title,style: const TextStyle(fontSize:18 ),),
                        Text(value,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                    ),
                  ),
                );
  }
}