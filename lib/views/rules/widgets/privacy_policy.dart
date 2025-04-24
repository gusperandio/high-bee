import 'package:flutter/material.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';

class PrivacyPolicyModal extends StatelessWidget {
  @override
  final VoidCallback onTap;

  const PrivacyPolicyModal({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Política de Privacidade - High Bee',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    const Text(
                      "Política de Privacidade",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 1. Introdução
                    const Text(
                      "1. Introdução",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Esta Política de Privacidade descreve como o aplicativo High Bee coleta, usa, armazena e compartilha seus dados pessoais, conforme a Lei Geral de Proteção de Dados Pessoais (Lei nº 13.709/2018 - LGPD).",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 2. Dados Coletados
                    const Text(
                      "2. Dados Coletados",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Coletamos as seguintes informações pessoais:",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "• Nome e e-mail no momento do cadastro",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Dados de uso, como visualizações, interações e postagens",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Dados de pagamento, quando aplicável (assinaturas)",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Endereço IP e dados do dispositivo",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 3. Uso dos Dados
                    const Text(
                      "3. Uso dos Dados",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Os dados são utilizados para:",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "• Permitir o funcionamento da plataforma",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Personalizar a experiência do usuário",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Gerenciar o sistema de aprovação e moderação de conteúdo",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Processar pagamentos de funcionalidades premium",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Enviar comunicações importantes relacionadas ao uso da plataforma",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Atender a obrigações legais",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 4. Compartilhamento de Dados
                    const Text(
                      "4. Compartilhamento de Dados",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Não compartilhamos seus dados com terceiros, exceto:",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "• Com provedores de serviços essenciais (ex: servidores, processadores de pagamento)",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Quando exigido por ordem judicial ou autoridade legal competente",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Em caso de investigações de violação dos Termos de Uso",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 5. Armazenamento e Segurança
                    const Text(
                      "5. Armazenamento e Segurança",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Os dados são armazenados em ambientes seguros, utilizando criptografia e boas práticas de segurança. O usuário pode solicitar a exclusão de seus dados a qualquer momento, conforme disposição da LGPD.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 6. Cookies e Tecnologias Similares
                    const Text(
                      "6. Cookies e Tecnologias Similares",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Utilizamos cookies e tecnologias similares para analisar o desempenho do aplicativo, lembrar preferências e melhorar a experiência do usuário.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 7. Direitos do Usuário
                    const Text(
                      "7. Direitos do Usuário",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "O usuário tem os seguintes direitos:",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "• Acessar seus dados pessoais",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Corrigir dados incorretos ou incompletos",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Solicitar exclusão ou anonimização",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Revogar consentimentos previamente dados",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Portar seus dados para outro serviço",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 8. Retenção de Dados
                    const Text(
                      "8. Retenção de Dados",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Os dados são mantidos enquanto o usuário mantiver conta ativa ou conforme exigido por lei. Dados relacionados às interações e publicações podem ser mantidos para fins legais mesmo após exclusão da conta.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 9. Atualizações da Política
                    const Text(
                      "9. Atualizações da Política",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Esta Política de Privacidade pode ser atualizada periodicamente. Notificaremos os usuários em caso de alterações significativas.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 10. Contato
                    const Text(
                      "10. Contato",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Em caso de dúvidas ou solicitações sobre privacidade, entre em contato: high.bee.cannabis@gmail.com",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // Versão
                    const Center(
                      child: Text(
                        "Versão: 1.0 | Atualizado em: abril de 2025",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Button.success(
                  title: "ACEITO",
                  onPressed: () {
                    onTap();
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
