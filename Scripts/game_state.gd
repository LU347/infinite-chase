extends Node

signal on_game_state_changed

enum GameStates {
    MAIN_MENU,
    ACTIVE,
    PAUSED,
    RESTARTING,
    OVER
}

var current_state: GameStates

func update_game_state(state: GameStates):
    current_state = state
    on_game_state_changed.emit()
