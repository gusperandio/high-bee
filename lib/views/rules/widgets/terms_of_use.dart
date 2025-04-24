import 'package:flutter/material.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';

class TermsOfUseModal extends StatelessWidget {
  final VoidCallback onTap;
  const TermsOfUseModal({super.key, required this.onTap});

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
                'Termos de Uso - High Bee',
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    const Text(
                      "Termos de Uso",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 1. Aceitação dos Termos
                    const Text(
                      "1. Aceitação dos Termos",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Ao acessar e utilizar o aplicativo High Bee, você concorda em cumprir estes Termos de Uso, a Política de Privacidade e todas as leis e regulamentos aplicáveis. Caso não concorde com algum dos termos aqui descritos, não utilize o aplicativo.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 2. Objetivo da Plataforma
                    const Text(
                      "2. Objetivo da Plataforma",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "O High Bee tem como objetivo principal promover o compartilhamento de informações educacionais, científicas e culturais sobre cannabis, cânhamo e seus derivados, respeitando integralmente as legislações brasileiras vigentes, especialmente as RDCs nº 96/2008 e 327/2019 da ANVISA.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 3. Cadastro e Acesso
                    const Text(
                      "3. Cadastro e Acesso",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Para utilizar o aplicativo, o usuário deve ser maior de 18 anos e realizar o cadastro fornecendo informações verídicas. O usuário é responsável por manter a confidencialidade de sua senha e credenciais.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 4. Regras de Conteúdo
                    const Text(
                      "4. Regras de Conteúdo",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "É expressamente proibido:",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "• Divulgar, comercializar ou promover produtos de cannabis não autorizados pela ANVISA",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Fazer propaganda de produtos medicinais derivados de cannabis (Art. 12, RDC 327/2019)",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Divulgar curas milagrosas ou promessas terapêuticas sem respaldo científico",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Publicar instruções sobre cultivo pessoal de cannabis",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Incentivar o uso recreativo da cannabis",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Publicar conteúdo falso, ofensivo, discriminatório ou que viole leis brasileiras",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Exibir endereços e localizações de estabelecimentos físicos relacionados à planta",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Conteúdos permitidos incluem:",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "• Informações científicas, históricas e culturais",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Relatos pessoais sem caráter terapêutico ou comercial",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Divulgação de eventos e iniciativas educacionais devidamente autorizadas",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Informações sobre o uso industrial do cânhamo",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "• Publicações sobre produtos de tabacarias e jardinagem, desde que não infrinjam legislação",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 5. Sistema de Moderação e Denúncias
                    const Text(
                      "5. Sistema de Moderação e Denúncias",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "O aplicativo conta com sistema de aprovação comunitária e ferramentas de denúncia de conteúdo. O High Bee se reserva o direito de remover qualquer publicação que esteja em desacordo com os Termos de Uso ou que represente risco à segurança da comunidade.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 6. Responsabilidades do Usuário
                    const Text(
                      "6. Responsabilidades do Usuário",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "O usuário é integralmente responsável pelas informações que publica, devendo garantir a veracidade e legalidade do conteúdo. Em caso de descumprimento, poderá ser suspenso ou banido da plataforma.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 7. Disponibilização de Dados
                    const Text(
                      "7. Disponibilização de Dados",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "O High Bee poderá fornecer dados do usuário às autoridades competentes mediante ordem judicial ou requisição legal, respeitando a LGPD (Lei Geral de Proteção de Dados).",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 8. Modificações dos Termos
                    const Text(
                      "8. Modificações dos Termos",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Estes Termos podem ser atualizados periodicamente. É responsabilidade do usuário revisar os termos regularmente.",
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // 9. Contato
                    const Text(
                      "9. Contato",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Dúvidas e sugestões podem ser enviadas para high.bee.cannabis@gmail.com.",
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
                  title: "Concordo",
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
