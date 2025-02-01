import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_sattes.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: getThemeColor(
                    BlocProvider.of<GetWeatherCubit>(context)
                            .weatherModel
                            ?.weatherStatus ??
                        ''),
              ),
              home: HomeView(),
            );
          },
        ),
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  // Grouping similar weather conditions based on the day attribute
  if (condition == null) {
    return Colors.grey;
  }
  switch (condition.toLowerCase()) {
    case 'sunny':
      return Colors.yellow; // Sunny
    case 'partly cloudy':
      return Colors.blueGrey; // Partly cloudy
    case 'cloudy':
    case 'overcast':
    case 'mist':
    case 'fog':
      return Colors.grey; // Cloudy, Overcast, Mist, Fog
    case 'patchy rain possible':
    case 'light rain':
    case 'moderate rain at times':
    case 'heavy rain at times':
    case 'heavy rain':
    case 'patchy light rain':
      return Colors.blue; // Rainy conditions
    case 'patchy snow possible':
    case 'patchy sleet possible':
    case 'light snow':
    case 'moderate snow':
    case 'heavy snow':
    case 'patchy light snow':
    case 'patchy heavy snow':
      return Colors.lightBlue; // Snowy conditions
    case 'blowing snow':
    case 'blizzard':
      return Colors.blueGrey; // Snowstorm conditions
    case 'freezing fog':
    case 'freezing drizzle':
    case 'heavy freezing drizzle':
    case 'light freezing rain':
    case 'moderate or heavy freezing rain':
      return Colors.cyan; // Freezing conditions
    case 'thundery outbreaks possible':
    case 'patchy light rain with thunder':
    case 'moderate or heavy rain with thunder':
    case 'patchy light snow with thunder':
    case 'moderate or heavy snow with thunder':
      return Colors.purple; // Thunderstorms
    default:
      return Colors.grey; // Default color for unknown conditions
  }
}
