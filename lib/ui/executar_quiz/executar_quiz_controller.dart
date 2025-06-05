import 'package:flutter/material.dart';
import 'package:iplay/core/dtos/jogo_dto.dart';
import 'package:iplay/core/enums/state_enum.dart';
import 'package:iplay/core/enums/tipo_perguntas.dart';
import 'package:iplay/core/functions/identificar_erro.dart';
import 'package:iplay/core/model/opcao_resposta_model.dart';
import 'package:iplay/core/model/pergunta_model.dart';
import 'package:iplay/core/repositories/perguntas_repository.dart';
import 'package:iplay/core/services/snackbar_service.dart';
import 'dart:developer' as developer;

class ExecutarQuizController extends ChangeNotifier {
  final PerguntasRepository perguntasRepository;
  final SnackBarService snackBarService;
  ExecutarQuizController({required this.perguntasRepository, required this.snackBarService});

  StateEnum state = StateEnum.inicial;
  bool carregandoJogos = false;
  bool criandoQuiz = false;
  List<PerguntaModel> perguntas = [];
  int indexPerguntaAtual = 1;
  TextEditingController nomeJogoController = TextEditingController();
  List<JogoDto> jogos = [];
  List<JogoDto> jogosSelecionados = [];
  bool buscarMaisJogos = true;

  Future<void> buscarPerguntas() async {
    try {
      setState(StateEnum.carregando);
      perguntas = await perguntasRepository.buscarPerguntas();
      setState(StateEnum.inicial);
    } catch (e, s) {
      developer.log('Erro ao buscar perguntas: $e', error: e, stackTrace: s);
      snackBarService.showMessage(message: identificarErro(error: e, message: 'Erro ao buscar perguntas.'), color: Colors.red);
      setState(StateEnum.erro);
    }
  }

  Future<bool> registrarQuiz() async {
    try {
      setCriandoQuiz(true);
      await perguntasRepository.registrarQuiz(dadosQuiz);
      snackBarService.showMessage(message: 'Quiz registrado com sucesso!', color: Colors.green);
      setCriandoQuiz(false);
      return true;
    } catch (e, s) {
      developer.log('Erro ao registrar quiz: $e', error: e, stackTrace: s);
      snackBarService.showMessage(message: identificarErro(error: e, message: 'Erro ao registrar quiz.'), color: Colors.red);
      setCriandoQuiz(false);
      return false;
    }
  }

  Map<String, dynamic> get dadosQuiz {
    Map<String, dynamic> dados = {};

    for (PerguntaModel pergunta in perguntas) {
      if (pergunta.perguntaDto.tipoPergunta == TipoPerguntasEnum.variosCheckBox) {
        final tag = pergunta.perguntaDto.tag;
        final respostas = pergunta.respostaOpcoesSelecionadas;
        dados[tag] = respostas;
      } else {
        final tag = pergunta.perguntaDto.tag;
        final respostas = jogosSelecionados.map((jogo) => jogo.valor).toList();
        dados[tag] = respostas;
      }
    }
    return dados;
  }

  Future<void> buscarJogos() async {
    if (buscarMaisJogos == false) {
      return;
    }
    try {
      setCarregandoJogos(true);
      final resultado = await perguntasRepository.buscarJogos(
        nomeJogo: nomeJogoController.text.isNotEmpty ? nomeJogoController.text : null,
        maximoJogos: jogos.length + 15,
      );
      jogos = resultado.jogos;
      buscarMaisJogos = resultado.temMaisJogos;
    } catch (e, s) {
      developer.log('Erro ao buscar jogos: $e', error: e, stackTrace: s);
      snackBarService.showMessage(message: identificarErro(error: e, message: 'Erro ao buscar jogos.'), color: Colors.red);
    } finally {
      setCarregandoJogos(false);
    }
  }

  bool jogoSelecionado(JogoDto jogo) {
    return jogosSelecionados.contains(jogo);
  }

  Future<bool> toggleAvancarPergunta() async {
    if (perguntas.isNotEmpty && indexPerguntaAtual < perguntas.length) {
      if (perguntaAtual != null) {
        if (perguntaAtual?.perguntaDto.tipoPergunta == TipoPerguntasEnum.variosCheckBox) {
          avancarPergunta();
        } else {
          avancarPerguntaJogos();
        }
      }
    } else if (indexPerguntaAtual == perguntas.length) {
      if (perguntaAtual!.quantidadeOpcoesSelecionadas >= perguntaAtual!.perguntaDto.minimoRespostas) {
        return await registrarQuiz();
      } else {
        snackBarService.showMessage(
          message: 'Selecione pelo menos ${perguntaAtual!.perguntaDto.minimoRespostas} opções.',
          color: Colors.red,
        );
      }
    }
    return false;
  }

  void avancarPergunta() {
    if (perguntaAtual!.quantidadeOpcoesSelecionadas >= perguntaAtual!.perguntaDto.minimoRespostas) {
      setIndexPerguntaAtual(indexPerguntaAtual + 1);
    } else {
      snackBarService.showMessage(
        message: 'Selecione pelo menos ${perguntaAtual!.perguntaDto.minimoRespostas} opções.',
        color: Colors.red,
      );
    }
  }

  void avancarPerguntaJogos() {
    if (jogosSelecionados.length > 2) {
      setIndexPerguntaAtual(indexPerguntaAtual + 1);
    } else {
      snackBarService.showMessage(
        message: 'Selecione pelo menos 3 jogos.',
        color: Colors.red,
      );
    }
  }

  String get scaffoldTitulo {
    if (perguntas.isEmpty) {
      return 'Quiz';
    }
    return "$indexPerguntaAtual/${perguntas.length}";
  }

  void toggleSelecionarJogo(JogoDto jogo) {
    if (jogosSelecionados.contains(jogo)) {
      jogosSelecionados.remove(jogo);
    } else {
      jogosSelecionados.add(jogo);
    }
    if (hasListeners) {
      notifyListeners();
    }
  }

  void toogleSelecionarOpcao(OpcaoRespostaModel opcao) {
    if (perguntaAtual != null) {
      opcao.tooggleSelecionada();
      if (hasListeners) {
        notifyListeners();
      }
    }
  }

  PerguntaModel? get perguntaAtual {
    if (perguntas.isNotEmpty && indexPerguntaAtual <= perguntas.length) {
      return perguntas[indexPerguntaAtual - 1];
    }
    return null;
  }

  void voltarPergunta() {
    if (indexPerguntaAtual > 1) {
      setIndexPerguntaAtual(indexPerguntaAtual - 1);
    } else {
      snackBarService.showMessage(
        message: 'Você já está na primeira pergunta.',
        color: Colors.orange,
      );
    }
  }

  void setState(StateEnum novoState) {
    state = novoState;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setPerguntas(List<PerguntaModel> novasPerguntas) {
    perguntas = novasPerguntas;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setIndexPerguntaAtual(int novoIndex) {
    indexPerguntaAtual = novoIndex;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setCarregandoJogos(bool novoCarregando) {
    carregandoJogos = novoCarregando;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setCriandoQuiz(bool novoCriando) {
    criandoQuiz = novoCriando;
    if (hasListeners) {
      notifyListeners();
    }
  }

  void setJogos(List<JogoDto> novosJogos) {
    jogos = novosJogos;
    if (hasListeners) {
      notifyListeners();
    }
  }
}
