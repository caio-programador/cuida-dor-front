// pages/terms/view/terms.view.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.all(8),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          'Termos e Condições',
          style: TextStyle(
            color: AppTheme.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo ao nosso aplicativo! Ao acessar ou utilizar este aplicativo, você concorda com os seguintes Termos e Condições. Recomendamos que leia atentamente antes de utilizá-lo.',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textDark,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('1. Aceitação dos Termos'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'Ao utilizar o aplicativo, o usuário declara que leu, compreendeu e concorda em cumprir estes Termos e Condições, bem como todas as leis e regulamentos aplicáveis. Caso não concorde, não deverá utilizá-lo.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('2. Uso do Aplicativo'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'O aplicativo destina-se apenas para fins pessoais e não comerciais. É proibido utilizá-lo para atividades ilegais, ofensivas, fraudulentas ou que possam causar danos a terceiros ou ao próprio sistema.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('3. Cadastro e Responsabilidade do Usuário'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'Alguns recursos podem exigir cadastro. O usuário é responsável por fornecer informações verdadeiras, manter seus dados atualizados e proteger suas credenciais de acesso.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('4. Privacidade'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'A coleta e o uso de dados pessoais estão sujeitos à nossa Política de Privacidade. Ao utilizar o aplicativo, você concorda com o tratamento de seus dados conforme descrito nessa política.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('5. Propriedade Intelectual'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'Todos os direitos de propriedade intelectual relacionados ao aplicativo, incluindo, mas não se limitando a, textos, gráficos, logotipos, ícones e código-fonte, pertencem exclusivamente aos desenvolvedores ou seus licenciadores.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('6. Limitação de Responsabilidade'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'O aplicativo é fornecido "no estado em que se encontra". Não garantimos que estará sempre disponível, livre de erros ou isento de vírus. Não nos responsabilizamos por danos diretos ou indiretos resultantes do uso do aplicativo.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('7. Modificações nos Termos'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'Reservamo-nos o direito de modificar estes Termos e Condições a qualquer momento. As alterações entrarão em vigor imediatamente após sua publicação no aplicativo. Recomendamos que revise periodicamente estes termos.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('8. Rescisão'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'Podemos suspender ou encerrar seu acesso ao aplicativo a qualquer momento, sem aviso prévio, caso você viole estes Termos e Condições.',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('9. Contato'),
            const SizedBox(height: 12),
            _buildSectionContent(
              'Se tiver dúvidas ou preocupações sobre estes Termos e Condições, entre em contato conosco através do email: contato@cuidador.com.br',
            ),
            const SizedBox(height: 24),

            Center(
              child: Text(
                'Última atualização: Novembro de 2025',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.terciary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.textDark,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 14,
        color: AppTheme.textDark,
        height: 1.5,
      ),
    );
  }
}
