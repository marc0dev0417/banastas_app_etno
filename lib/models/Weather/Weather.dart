class Weather {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentWeather? currentWeather;

  Weather(
      {this.latitude,
        this.longitude,
        this.generationtimeMs,
        this.utcOffsetSeconds,
        this.timezone,
        this.timezoneAbbreviation,
        this.elevation,
        this.currentWeather});

  Weather.empty();

  Weather.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentWeather = json['current_weather'] != null
        ? new CurrentWeather.fromJson(json['current_weather'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['generationtime_ms'] = this.generationtimeMs;
    data['utc_offset_seconds'] = this.utcOffsetSeconds;
    data['timezone'] = this.timezone;
    data['timezone_abbreviation'] = this.timezoneAbbreviation;
    data['elevation'] = this.elevation;
    if (this.currentWeather != null) {
      data['current_weather'] = this.currentWeather!.toJson();
    }
    return data;
  }
}

class CurrentWeather {
  double? temperature;
  double? windspeed;
  double? winddirection;
  int? weathercode;
  String? time;

  CurrentWeather(
      {this.temperature,
        this.windspeed,
        this.winddirection,
        this.weathercode,
        this.time});

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    windspeed = json['windspeed'];
    winddirection = json['winddirection'];
    weathercode = json['weathercode'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['windspeed'] = this.windspeed;
    data['winddirection'] = this.winddirection;
    data['weathercode'] = this.weathercode;
    data['time'] = this.time;
    return data;
  }
}