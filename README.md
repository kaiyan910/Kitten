# Kitten
A Flutter sample project showing list of cat photos from TheCatAPI.  
![screenshot](https://github.com/kaiyan910/Kitten/blob/master/static/screenshot.png?raw=true)

## Things included
1. BLoC architecture
2. Restful API integration
3. SQLite database implementation
4. SharedPreferences implementation
4. Mutli-Locale implementation

## Register account for TheCatApi
click [here](https://thecatapi.com/) to register account.


## Create extra file
create `constant.dart` at `/lib/src/core/` with content below:

```dart
class Constant {
  static const String API_KEY = "API_KEY_FROM_THE_CAT_API";
}
```
