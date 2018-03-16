<template>
  <div class="board-container">
    <span v-for="(valid, column) in validMoves" :key="column">
        <button @click="$emit('move', column)" :disabled="!valid" class="board-element">{{ column }}</button>
    </span>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    moves: {
      type: Array,
      required: true,
      validator: function (moves) {
        return moves.reduce(function(valid, move) {
          return valid && !isNaN(move) && (move >= 0) && (move <= 6)
        }, true)
      }
    },
    movesAllowed: {
      type: Boolean,
      required: true
    },
    gameResult: {
      type: String,
      required: true,
      validator: function (gameResult) {
        return (gameResult == '1') || (gameResult == '2') || (gameResult == 'tie') || (gameResult == 'incomplete')
      }
    },
    currentPlayerType: {
      type: String,
      required: true,
      validator: function (playerType) {
        return (playerType == 'human') || (playerType == 'computer')
      }
    }
  },
  computed: {
    validMoves: function () {
      if ((this.currentPlayerType == 'human') && (this.movesAllowed) && (this.gameResult == 'incomplete')) {
        let validMoves = []
        for (let candidateMove = 0; candidateMove < 7; candidateMove++) {
            let priorMoveCount = 0
            for (let i = 0; i < this.moves.length; i++){
            if (this.moves[i] == candidateMove) {
                priorMoveCount++
            }
            }
            validMoves.push(priorMoveCount < 6)
        }
        return validMoves
      } else {
          return [false, false, false, false, false, false, false]
      }
    }
  }
}
</script>

<style scoped>
.board-container {
    text-align: center;
}
.board-element {
    display: inline-block;
    width: 30px;
    height: 30px;
}
</style>
