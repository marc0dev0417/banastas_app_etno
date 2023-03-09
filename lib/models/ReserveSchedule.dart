class ReserveSchedule {
  String? idReserveSchedule;
  String? date;

  ReserveSchedule(this.idReserveSchedule, this.date);

  ReserveSchedule.fromJson(Map<String, dynamic> json) {
    idReserveSchedule = json['idReserveSchedule'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['idReserveSchedule'] = idReserveSchedule;
    data['date'] = date;
    return data;
  }
}