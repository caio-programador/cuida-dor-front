enum SexUser {
  masculino(value: 'masculino'),
  feminino(value: 'feminino'),
  naoInformar(value: 'nao_identificar');

  final String value;

  const SexUser({required this.value});
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final SexUser? sex;
  final String? comorbidities;
  final String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.sex,
    this.comorbidities,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      sex: SexUser.values.firstWhere((e) => e.value == json['sex']),
      comorbidities: json['comorbidades'],
      role: json['role'],
    );
  }
}
