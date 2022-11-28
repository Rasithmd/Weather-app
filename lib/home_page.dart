import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc_screen.dart';
import 'package:weather_app/model/weather_list.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/widget/weather_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  DateTime todaydate = DateTime.now();
  String imageUrl = '';

  Future<void> getData() async {
    data = await client.getCurrentWeather("Ramanathapuram");
  }

  List<WeatherListModel> listWeather = [];

  @override
  Widget build(BuildContext context) {
    listWeather = context.watch<WeatherListBloc>().list;
    Size size = MediaQuery.of(context).size;
    context.read<WeatherListBloc>().loadData();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 58, 97, 128),
          title: const Text(
            "Weather",
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.cityName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(todaydate).toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          color: const Color(0xff90B2F9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff90B2F8).withOpacity(.5),
                              offset: const Offset(0, 25),
                              blurRadius: 10,
                              spreadRadius: -12,
                            )
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -40,
                            left: 20,
                            child: imageUrl != ''
                                ? const Text('')
                                : Image.asset(
                                    'assets/heavycloud.png',
                                    width: 150,
                                  ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 20,
                            child: Text(
                              listWeather[0].main!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    data!.temp!.toString(),
                                    style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = linearGradient,
                                    ),
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WeatherItem(
                            text: 'Wind Speed',
                            value: data!.wind!.toInt(),
                            unit: 'km/h',
                            imageUrl: 'assets/windspeed.png',
                          ),
                          WeatherItem(
                              text: 'Humidity',
                              value: data!.humidity!,
                              unit: '',
                              imageUrl: 'assets/humidity.png'),
                          WeatherItem(
                            text: 'Max Temp',
                            value: data!.temp_max!.toInt(),
                            unit: 'C',
                            imageUrl: 'assets/max-temp.png',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }
}
