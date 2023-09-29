import 'dart:io';
import 'dart:math';

void main() {
  int vitoriasUsuario = 0;
  int vitoriasComputador = 0;
  int empates = 0;
  bool usarDadoMagico =
      false; // Flag para controlar se o "dado mágico" foi usado.

  print("Quantas rodadas você deseja jogar?");
  int totalRodadas = int.parse(stdin.readLineSync()!);

  for (int rodadaAtual = 1; rodadaAtual <= totalRodadas; rodadaAtual++) {
    print("\nRodada $rodadaAtual:");

    // Verifica se o usuário deseja usar o "dado mágico" nesta rodada.
    if (!usarDadoMagico) {
      print(
          "Você deseja usar o 'dado mágico' nesta rodada? (s para Sim, qualquer outra tecla para Não)");
      String resposta = stdin.readLineSync()!;
      usarDadoMagico = (resposta.toLowerCase() == 's');
    }

    List<int> dadosUsuario = rolarDados(3);
    List<int> dadosComputador = rolarDados(3);

    int somaUsuario = dadosUsuario.reduce((a, b) => a + b);
    int somaComputador = dadosComputador.reduce((a, b) => a + b);

    // Aplica o "dado mágico" somente para o total do usuário, na rodada em que foi usado.
    if (usarDadoMagico) {
      int sorteio = Random().nextInt(2); // Sorteia 0 ou 1.
      if (sorteio == 0) {
        print(
            "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
        print(
            "Você usou o 'dado mágico' e sua soma total foi reduzida pela metade!");
        somaUsuario = (somaUsuario ~/ 2); // Reduz a soma pela metade.
      } else {
        print(
            "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
        print("Você usou o 'dado mágico' e sua soma total foi dobrada!");
        somaUsuario *= 2; // Dobra a soma.
      }
    }

    print("Seus dados: $dadosUsuario (Total: $somaUsuario)");
    print("Dados do computador: $dadosComputador (Total: $somaComputador)");

    if (somaUsuario > somaComputador) {
      print("Você venceu esta rodada!");
      vitoriasUsuario++;
    } else if (somaComputador > somaUsuario) {
      print("O computador venceu esta rodada!");
      vitoriasComputador++;
    } else {
      print("Esta rodada terminou em empate!");
      empates++;
    }
  }

  // Exibe o placar final das rodadas.
  print(
      "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
  print("Placar final:");
  print("Você venceu: $vitoriasUsuario rodada(s)");
  print("Computador venceu: $vitoriasComputador rodada(s)");
  print("Empates: $empates rodada(s)");

  // Determina o vencedor final com base no placar de vitórias.
  if (vitoriasUsuario > vitoriasComputador) {
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    print("Você é o vencedor final!!!");
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
  } else if (vitoriasComputador > vitoriasUsuario) {
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    print("O computador é o vencedor final!!!");
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
  } else {
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
    print("O jogo terminou em empate!");
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
  }
}

// Função para simular a rolagem de um dado de seis faces 'n' vezes.
List<int> rolarDados(int n) {
  Random random = Random();
  List<int> resultados = [];
  for (int i = 0; i < n; i++) {
    resultados
        .add(random.nextInt(6) + 1); // Gera um número aleatório entre 1 e 6.
  }
  return resultados;
}
