# leave_app
Flutter Learning Resource : Asynchronous Programming

## Flutter
Register UI
- firstname
- lastname
- email
- password
- button (Navigate to Leaves.dart)
parse data as a map. ie.

```dart 
Map profile = {
    'firtname' : 'John',
    'lastname' : 'Doe',
    'email' :   'joe@doe.com',
    'password' : 'itsJ03!',
}
// Remember to validate
```
LeavePage
show 
- 'Good Morning name,
```dart
String greeting(Strin name){
    Datetime now = dateTime.now()
    if(now.hour<12){
        return 'Good Morning $name'
    } elseif(now.hour>12){
        return 'Good Afternoon $name'
    }
}

<<<<<<< HEAD
add http to pubspec.yaml

password : info@titus.co.k3
username: modcomflutter
host : modcomflutter.mysql.pythonanywhere-services.com
=======
// Usage
Text(greeting(profile['firstname']))
```

- username(from email)
```dart
Text(profile['email'].split('@')[0])
```
add http to pubspec.yaml
>>>>>>> 83681f7c6f4f5caaf961158e8b03f068687f9e65
