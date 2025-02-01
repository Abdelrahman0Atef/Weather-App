import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/main.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weatherCondition =
        BlocProvider.of<GetWeatherCubit>(context).weatherModel?.weatherStatus ??
            '';
    final themeColor = getThemeColor(weatherCondition);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for a City'),
        backgroundColor: themeColor,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title and instruction
              const Text(
                "Find Weather Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Search TextField with modern style
              TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Search City',
                  labelStyle: const TextStyle(color: Colors.black),
                  hintText: 'Enter City Name',
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: themeColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: themeColor.withOpacity(0.6), width: 1.5),
                  ),
                ),
                onSubmitted: (value) async {
                  var getWeaterCubit =
                      BlocProvider.of<GetWeatherCubit>(context);
                  getWeaterCubit.getCurrentWeather(cityName: value);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
