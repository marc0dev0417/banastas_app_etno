class Quiz {
  String? idQuiz;
  String? username;
  String? question;
  String? answerOne;
  int? resultOne;
  String? answerTwo;
  int? resultTwo;
  String? answerThree;
  int? resultThree;
  String? answerFour;
  int? resultFour;
  bool? isActive;

  Quiz(
      this.idQuiz,
      this.username,
      this.question,
      this.answerOne,
      this.resultOne,
      this.answerTwo,
      this.resultTwo,
      this.answerThree,
      this.resultThree,
      this.answerFour,
      this.resultFour,
      this.isActive
      );

  Quiz.fromJson(Map<String, dynamic> json) {
    idQuiz = json['idQuiz'];
    username = json['username'];
    question = json['question'];
    answerOne = json['answerOne'];
    resultOne = json['resultOne'];
    answerTwo = json['answerTwo'];
    resultTwo = json['resultTwo'];
    answerThree = json['answerThree'];
    resultThree = json['resultThree'];
    answerFour = json['answerFour'];
    resultFour = json['resultFour'];
    isActive = json['isActive'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{  };
    data['idQuiz'] = idQuiz;
    data['username'] = username;
    data['question'] = question;
    data['answerOne'] = answerOne;
    data['resultOne'] = resultOne;
    data['answerTwo'] = answerTwo;
    data['resultTwo'] = resultTwo;
    data['answerThree'] = answerThree;
    data['resultThree'] = resultThree;
    data['answerFour'] = answerFour;
    data['resultFour'] = resultFour;
    data['isActive'] = isActive;
    return data;
  }
}