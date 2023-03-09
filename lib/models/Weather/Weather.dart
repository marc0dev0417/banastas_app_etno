class Weather {
  int? cloud_pct;
  int? temp;
  int? feels_like;
  int? humidity;
  int? min_temp;
  int? max_temp;
  double? wind_speed;
  int? wind_degrees;
  int? sunrise;
  int? sunset;

  Weather.empty();
  Weather(this.cloud_pct, this.temp, this.feels_like, this.humidity, this.min_temp, this.max_temp, this.wind_speed, this.wind_degrees, this.sunrise, this.sunset);

  Weather.fromJson(Map<String, dynamic> json) {
    cloud_pct = json['cloud_pct'];
    temp = json['temp'];
    feels_like = json['feels_like'];
    humidity = json['humidity'];
    min_temp = json['min_temp'];
    max_temp = json['max_temp'];
    wind_speed = json['wind_speed'];
    wind_degrees = json['wind_degrees'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{ };
    data['cloud_pct'] = cloud_pct;
    data['temp'] = temp;
    data['feels_like'] = feels_like;
    data['humidity'] = humidity;
    data['min_temp'] = min_temp;
    data['max_temp'] = max_temp;
    data['wind_speed'] = wind_speed;
    data['wind_degrees'] = wind_degrees;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}