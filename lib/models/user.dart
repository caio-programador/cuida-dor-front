enum SexUser {
  masculino(value: 'masculino'),
  feminino(value: 'feminino'),
  naoInformar(value: 'nao_identificar');

  final String value;

  const SexUser({required this.value});
}

class User {
  final int id;
  final String name;
  final String email;
  final SexUser sex;
  final String comorbidities;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.sex,
    required this.comorbidities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      sex: SexUser.values.firstWhere((e) => e.value == json['sex']),
      comorbidities: json['comorbidities'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'sex': sex.value,
      'comorbidities': comorbidities,
    };
  }
}
