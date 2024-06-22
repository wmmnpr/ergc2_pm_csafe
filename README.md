A Dart library for interacting with the PM5 from concept2 via Bluetooth. 
See flutter_pm5 to be able to easily use this library with Flutter.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

#useful jq filters

#extract value for a particular characteristic:
jq  '.[] | select(.["_source"]["layers"]["btatt"]["btatt.handle_tree"]["btatt.uuid128"] == "ce:06:00:33:43:e5:11:e4:91:6c:08:00:20:0c:9a:66")' pm5-ergdata-airplus-202406092300-full.json | jq  '.["_source"]["layers"]["btatt"]["btatt.value"]' 

#same but with a comman at the end.
jq  '.[] | select(.["_source"]["layers"]["btatt"]["btatt.handle_tree"]["btatt.uuid128"] == "ce:06:00:33:43:e5:11:e4:91:6c:08:00:20:0c:9a:66")' pm5-ergdata-airplus-202406092300-full.json | jq  '(.["_source"]["layers"]["btatt"]["btatt.value"])+","' 





















