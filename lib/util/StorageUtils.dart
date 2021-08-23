import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class StorageUtils{

  Future<void>setStringGetStorage(String key,String value){
    return box.write(key, value);
  }

  getStringGetStorage(String key) async {
    var result = await box.read(key);
    return result;
  }

}