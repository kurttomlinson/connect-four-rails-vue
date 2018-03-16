<template>
  <div>
    <h1 class="centered">Connect Four in Ruby on Rails and Vue</h1>
    <div class="player-selector-container">
      <PlayerSelector
        :player=1
        :playerType="playerOneType"
        @setPlayerType="setPlayerType" />
      <PlayerSelector
        :player=2
        :playerType="playerTwoType"
        @setPlayerType="setPlayerType" />
    </div>
    <br/>
    <SearchDepthSelector
      :searchDepth="searchDepth"
      @setSearchDepth="setSearchDepth"/>
    <br/>
    <div class="centered">Player to move: {{ playerToMove }}</div>
    <MoveInput
      :moves=moves
      :movesAllowed=movesAllowed
      :gameResult=gameResult
      :currentPlayerType=currentPlayerType
      @move="move" />
    <GameBoard
      :moves=moves />
    <GameResult
      :gameResult=gameResult /><br/>
    <ResetButton
      @resetGame=resetGame />
    <h2>Instructions</h2>
    <p>The search depth determines how many moves into the future the computer should look before picking a move. Higher search depths make the computer a more difficult opponent.</p>
    <p>When it is a human's turn to play, click one of the buttons labeled "0" through "6" to pick a column for your move.</p>
    <p>Click the "Reset" button at any time to clear the game board and start over.</p>
    <h2>About</h2>
    <p><a href="https://github.com/kurttomlinson/connect-four-rails-vue">Connect Four Rails Vue</a> is built using Ruby on Rails and Vue.js. The Ruby on Rails backend computes the moves made by computer players and determines if a given sequence of moves corresponds with an end-game state (tie game, player one wins, player two wins) or an on-going game.</p>
    <p>The Ruby on Rails backend leverages <a href="https://github.com/kurttomlinson/console-connect-four">console-connect-four</a> to calculate computer moves and game results. The <strong>console-connect-four</strong> source code is included in the <strong>connect-four-rails-vue</strong> project as a git submodule.</p>
    <h2>Future Work</h2>
    <p>Although <strong>connect-four-rails-vue</strong> is in a working state, there are a few improvements I'd like to make in the future.</p>
    <p>First, I'd like to enable the ability to save and load games. This could be easily accomplished by creating a <strong>games</strong> table in the database with a string column named 'moves'. I'd use <strong>serialize :moves, Array</strong> in the games model to enable easy storage and retrieval of the move sequence for each saved game.</p>
    <p>Second, while importing <strong>console-connect-four</strong> as a git submodule is a workable solution, I'd like to turn it into a gem that could be more easily imported into the Rails backend without cluttering up the lib folder.</p>
  </div>
</template>

<script>
import axios from 'axios';
import PlayerSelector from './PlayerSelector.vue'
import GameBoard from './GameBoard.vue'
import MoveInput from './MoveInput.vue'
import ResetButton from './ResetButton.vue'
import GameResult from './GameResult.vue'
import SearchDepthSelector from './SearchDepthSelector.vue'

export default {
	components: {
		PlayerSelector, GameBoard, MoveInput, ResetButton, GameResult, SearchDepthSelector
	},
  data () {
    return {
      moves: [],
      playerOneType: "human",
      playerTwoType: "human",
      playerToMove: 1,
      gameResult: 'incomplete',
      movesAllowed: true,
      searchDepth: 3
    }
  },
  updated: function () {
    if ((this.movesAllowed) && (this.gameResult == 'incomplete')) {
      if (this.currentPlayerType == 'computer') {
        this.movesAllowed = false
        const computerMoveUrl = "/games/computer_move.json?moves=" + this.moves.toString() + "&depth=" + this.searchDepth
        axios.get(computerMoveUrl).then(response => {
          if (this.arraysAreEqual(this.moves, response.data.moves)) {
            this.move(response.data.computer_move)
          }
        })
      }
    }
  },
  computed: {
    currentPlayerType: function () {
      if (this.playerToMove == 1) {
        return this.playerOneType
      } else {
        return this.playerTwoType
      }
    }
  },
  methods: {
    setSearchDepth: function (searchDepth) {
      this.searchDepth = searchDepth
    },
    move: function (move_column) {
      this.moves.push(move_column)
      this.playerToMove = (this.playerToMove == 1) ? 2 : 1
      const gameResultUrl = "/games/game_result.json?moves=" + this.moves.toString()
      this.movesAllowed = false
      axios.get(gameResultUrl).then(response => {
        this.gameResult = response.data.game_result
        if (this.gameResult == 'incomplete') {
          this.movesAllowed = true
        }
      })
    },
    resetGame: function () {
      this.moves = []
      this.playerToMove = 1
      this.gameResult = 'incomplete'
      this.movesAllowed = true
    },
    setPlayerType: function (player, type) {
      if (player == 1) {
        this.playerOneType = type
      } else if (player == 2) {
        this.playerTwoType = type
      }
    },
    arraysAreEqual: function (arrayA, arrayB) {
      if (arrayA.length != arrayB.length) {
        return false
      }
      for (let i = 0; i < arrayA.length; i++) {
        if (arrayA[i] != arrayB[i]) {
          return false
        }
      }
      return true;
    }
  }
}
</script>

<style scoped>
.centered {
  text-align: center
}
.player-selector-container {
  justify-content: space-around;
  display: flex;
}
</style>
