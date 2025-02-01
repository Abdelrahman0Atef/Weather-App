import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_sattes.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_info_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weatherCondition =
        BlocProvider.of<GetWeatherCubit>(context).weatherModel?.weatherStatus;
    // Get the theme color based on the weather condition
    final themeColor = getThemeColor(weatherCondition);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for a City'),
        backgroundColor: themeColor,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SearchView();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return WeatherInfoBody(
              weather: state.weatherModel,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                  child: Text(
                'Oops There Was An Error, Try Again Later',
                style: TextStyle(color: Colors.black, fontSize: 25),
              )),
            );
          }
        },
      ),
    );
  }
}
