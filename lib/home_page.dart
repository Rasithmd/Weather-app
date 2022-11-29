import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api_client.dart';
import 'package:weather_app/widget/weather_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = <String>[
    'Manamadurai',
    'Sivaganga',
    'Ramanathapuram',
    'Trichy',
    'Chennai',
    'Madurai',
  ];

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  DateTime todaydate = DateTime.now();
  String imageUrl = '';
  String location = 'Manamadurai';
  Future<void> getData(String location) async {
    data = await client.getCurrentWeather(location);
  }

  @override
  void initState() {
    super.initState();
    getData(location);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Row(
            children: [
              const SizedBox(
                width: 150,
              ),
              Image.asset(
                'assets/pin.png',
                width: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton(
                    iconSize: 25,
                    value: location,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        location = newValue!;
                        getData(location);
                      });
                    }),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: getData(location),
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
                            top: -75,
                            left: 20,
                            child: imageUrl != ''
                                ? const Text('')
                                : Image.asset(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'assets/icon/' + data!.icon! + ".png",
                                    width: 150,
                                  ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 20,
                            child: Text(
                              data!.weather!.toString(),
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
