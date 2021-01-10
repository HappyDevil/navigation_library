class ResultModel {
  ResultModel({
    required this.resultCode,
    required this.result,
  });

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return new ResultModel(
      resultCode: map['resultCode'] as String,
      result: map['result'] as dynamic,
    );
  }

  final String resultCode;
  final dynamic result;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultModel &&
          runtimeType == other.runtimeType &&
          resultCode == other.resultCode &&
          result == other.result;

  @override
  int get hashCode => resultCode.hashCode ^ result.hashCode;

  @override
  String toString() {
    return 'ResultModel{resultCode: $resultCode, result: $result}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resultCode': this.resultCode,
      'result': this.result,
    };
  }
}
