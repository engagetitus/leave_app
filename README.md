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

// Usage
Text(greeting(profile['firstname']))
```

- username(from email)
```dart
Text(profile['email'].split('@')[0])
```
add http to pubspec.yaml