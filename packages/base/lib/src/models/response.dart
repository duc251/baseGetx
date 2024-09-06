import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
    ResponseModel({
        this.isErr,
        this.data,
        this.message,
    });

    final bool? isErr;
    final Map<String, dynamic>? data;
    final String? message;

    ResponseModel copyWith({
        bool? isErr,
        Map<String, dynamic>? data,
        String? message,
    }) => 
        ResponseModel(
            isErr: isErr ?? this.isErr,
            data: data ?? this.data,
            message: message ?? this.message,
        );

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        isErr: json["isErr"],
        data: json["data"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "isErr": isErr,
        "data": data,
        "message": message,
    };
}