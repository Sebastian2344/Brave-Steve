import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';
import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// Mockowanie klasy RepositoryGame
class MockRepositoryGame extends Mock implements RepositoryGame {}

// Mockowanie klasy PlayerModel
class MockPlayerModel extends Mock implements PlayerModel {}

void main() {
  late MockRepositoryGame mockRepositoryGame;
  late GameState gameState;
  late MyVars initialState;

  setUp(() {
    mockRepositoryGame = MockRepositoryGame();
    // Mockowanie danych startowych graczy
    final playerList = List<MockPlayerModel>.generate(8, (index) => MockPlayerModel());
    when(() => mockRepositoryGame.playersStartStatsasPlayerModelList()).thenReturn(playerList);

    gameState = GameState(mockRepositoryGame);
    initialState = gameState.state;
  });

  test('firstPlayerCome sets the state correctly when cleary is true', () {
    // Wywołanie metody z cleary = true
    gameState.firstPlayerCome(true);

    // Sprawdzamy czy stan został ustawiony poprawnie
    final newState = gameState.state;
    expect(newState.effect, [initialState.effect[0], initialState.effect[1], false, false]);
    expect(newState.buttonIgnore, [true, true, true, true]);
    expect(newState.move1, false);
  });

  test('firstPlayerCome sets the state correctly when cleary is false', () {
    // Wywołanie metody z cleary = false
    gameState.firstPlayerCome(false);

    // Sprawdzamy czy stan został ustawiony poprawnie
    final newState = gameState.state;
    expect(newState.effect, [initialState.effect[0], initialState.effect[1], false, false]);
    expect(newState.buttonIgnore, [true, true, true, true]);
    expect(newState.move1, true);
  });

}