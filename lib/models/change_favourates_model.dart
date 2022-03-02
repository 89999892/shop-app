class ChangeFavourateModel{
bool status;
String message;
ChangeFavourateModel({this.status, this.message});
ChangeFavourateModel.fromjson(Map<String ,dynamic>json){
  status=json['status'];
  message=json['message'];
}
}