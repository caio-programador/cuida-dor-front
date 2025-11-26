import 'package:flutter/material.dart';
import '../models/info_page.model.dart';

class MoreInfoController extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  int get totalPages => infoPages.length;
  bool get isLastPage => _currentIndex == totalPages - 1;

  final List<InfoPage> infoPages = [
    InfoPage(
      title: 'ENTENDENDO SUA CONDIÇÃO',
      icon: Icons.medical_information,
      content: '''**O que acontece?**

• Desgaste (ou artrose) é o desgaste natural da cartilagem que protege suas articulações
• Com o tempo, os ossos ficam mais próximos e a rigidez aumenta
• Pense assim: é como o desgaste de um pneu de carro - com o uso ao longo dos anos, a proteção vai diminuindo

**IMPORTANTE SABER:**

• É muito comum após os 60 anos
• NÃO é culpa sua
• Tem tratamento e controle
• Você pode viver bem com osteoartrite

**Articulações mais afetadas:**

• Joelhos
• Mãos e dedos
• Quadril
• Coluna
• Pés''',
    ),
    InfoPage(
      title: 'RECONHECENDO OS SINAIS',
      icon: Icons.search,
      content: '''**Sintomas principais:**

• Dor nas articulações (piora com movimento)
• Rigidez pela manhã (melhora em 30 minutos)
• Inchaço leve nas juntas
• Estalos ao movimentar
• Dificuldade para realizar tarefas simples
• Sensação de "travamento"
• Fadiga comum

**A dor varia durante o dia:**

🌅 Manhã: mais rígido
☀️ Tarde: melhora com movimento suave
🌙 Noite: pode doer após atividades

💡 A dor varia: Alguns dias são melhores - é normal!

**⚠️ QUANDO PROCURAR AJUDA URGENTE:**

• Dor muito forte e súbita
• Inchaço grande e vermelhidão
• Febre junto com dor
• Impossibilidade de mover a articulação''',
    ),
    InfoPage(
      title: 'POR QUE ACONTECE?',
      icon: Icons.help_outline,
      content: '''**Causas principais:**

🎂 Idade: desgaste natural ao longo da vida

🔄 Uso repetitivo: trabalhos que sobrecarregam

🤕 Lesões anteriores: fraturas, torções

⚖️ Sobrepeso: pressão extra nas articulações

🧬 Genética: histórico na família

🪑 Postura inadequada''',
    ),
    InfoPage(
      title: 'FATORES QUE VOCÊ PODE CONTROLAR',
      icon: Icons.fitness_center,
      content: '''**O que você pode controlar:**

✅ Peso corporal
✅ Atividade física regular
✅ Postura no dia a dia
✅ Proteção das articulações
✅ Alimentação saudável

**OPÇÕES DE TRATAMENTO**
🎯 Objetivo: Reduzir dor e manter movimento

**A) MEDICAMENTOS:**

💊 Analgésicos
💊 Anti-inflamatórios (com orientação médica)
💊 Pomadas e géis
💊 Suplementos

**B) PRÁTICAS INTEGRATIVAS (PICs):**
📱 Este app foca nestas práticas!

🧘 Exercícios adaptados
🌡️ Termoterapia
📍 Acupuntura/Acupressão
🧘‍♀️ Yoga e Tai Chi
💆 Massagem terapêutica
🌿 Fitoterapia

**C) FISIOTERAPIA:**

💪 Fortalecimento muscular
🤸 Melhora da mobilidade
🛡️ Técnicas de proteção articular''',
    ),
    InfoPage(
      title: 'MUDANÇAS NO ESTILO DE VIDA',
      icon: Icons.auto_awesome,
      content: '''**Mudanças positivas:**

⚖️ Perda de peso (se necessário)

🥗 Alimentação anti-inflamatória

🏃 Exercícios regulares

🏠 Adaptações no dia a dia''',
    ),
    InfoPage(
      title: 'TRATAMENTOS AVANÇADOS',
      icon: Icons.local_hospital,
      content: '''**Opções avançadas:**

💉 Infiltrações (injeções)

🧪 Viscosuplementação

⚕️ Cirurgia (casos específicos)

**🔄 ABORDAGEM INTEGRADA:**

O melhor resultado vem da **COMBINAÇÃO** de tratamentos, não apenas um.''',
    ),
    InfoPage(
      title: 'COMENDO PARA ALIVIAR',
      icon: Icons.restaurant_menu,
      content: '''**🟢 Alimentos AMIGOS (anti-inflamatórios):**

🐟 Peixes (salmão, sardinha)
🐠 Ômega 3
🫒 Azeite de oliva extra virgem
🥬 Vegetais verde-escuros
🍓 Frutas vermelhas
🧄 Alho e cebola
🫚 Gengibre e cúrcuma
🌰 Castanhas e nozes
🍊 Frutas cítricas (vitamina C)

**🔴 Alimentos a EVITAR ou REDUZIR:**

🍬 Açúcar em excesso
🍟 Frituras
🥓 Carnes processadas
🍺 Bebidas alcoólicas em excesso
🧂 Sal em excesso

**💧 HIDRATAÇÃO:**

Beba 6-8 copos de água por dia
A cartilagem precisa de água!''',
    ),
  ];

  void goToPage(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void nextPage() {
    if (_currentIndex < totalPages - 1) {
      goToPage(_currentIndex + 1);
    }
  }

  void previousPage() {
    if (_currentIndex > 0) {
      goToPage(_currentIndex - 1);
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
