### technical_test

Aplikasi List User.

### Getting Started

Aplikasi Flutter ini menggunakan pola BLoC (Business Logic Component) untuk get data User dari API https://reqres.in/api/users?page=2 dan menampilkan dalam bentuk List

### Struktur

```css
lib/
├── blocs/
│   └── user_bloc.dart
│   └── user_event.dart
│    └── user_state.dart
├── models/
│   └── user_model.dart
├── views/
│   └── user_list.dart
|   └── user_view.dart
└── main.dart
```

Depedency

```css
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.0.0
  http: ^0.14.0
  bloc: ^8.1.4
  http: ^1.1.0
  equatable: ^2.0.5
```

### Step

Buat Class Model untuk mempresentasikan response Json dari API

```dart
lib/models/user_model.dart
```

Buat class BloC yang berisi class bloc, state, event.

Class Event adalah triger yang dilakukan oleh user untuk mengerjakan sesuatu.

```dart
lib/bloc/bloc/user_event.dart
```

Class Bloc adalah tempat semua logic berisi yang telah ditriger dari Event. Lalu hasil akan di teruskan ke State

```dart
lib/bloc/bloc/user_bloc.dart
```

Class State untuk menampung data yang didapatkan dari hasil class bloc dan akan diteruskan ke view

```dart
lib/bloc/bloc/user_state.dart
```

Class View

Class View berisi user_view.dart dan user_list.dart.
Class

```dart
lib/views/user_view.dart
```

Class Tersebut berisi koneksi antara view dan bloc yang di lakukan user untuk mengambil data dari API. Fungsi yang digunakan adalah BlocProvider

```dart
 BlocProvider(
        create: (context) => UserBloc()..add(FetchUsers()),
        child: const UserList(),
      ),
```

Class

```dart
lib/views/user_list.dart
```

Class Tersebut berisi ui yang menampilkan data hasil dari get response API pada class Bloc. Fungsi yang digunakan adalah BlocBuilder

```dart
BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.userResponse.data.length,
            itemBuilder: (context, index) {
              var user = state.userResponse.data[index];
              return ListTile(
                leading: Image.network(
                  user.avatar,
                ),
                title: Text('${user.firstName} ${user.lastName}'),
                subtitle: Text(user.email),
              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    )

```
