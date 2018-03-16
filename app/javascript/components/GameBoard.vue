<template>
  <div class="board-container">
    <div v-for="(column, columnIndex) in boardState" :key="columnIndex">
        <span v-for="(element, rowIndex) in column" :key="rowIndex" class="board-element">
            {{ element }}
        </span>
    </div>
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
    }
  },
  computed: {
    boardState: function () {
      let columns = []
      let currentPlayer = '1'
      for (let i = 0; i < this.moves.length; i++) {
        let move = this.moves[i]
        if (typeof columns[move]  == 'undefined') {
          columns[move] = []
        }
        columns[move].push(currentPlayer)
        currentPlayer = (currentPlayer == '1') ? '2' : '1'
      }
      for (let i = 0; i < 7; i++) {
        if (typeof columns[i]  == 'undefined') {
          columns[i] = []
        }
        while (columns[i].length < 6) {
            columns[i].push('.')
        }
      }
      // transpose and reverse the array to make it easy to print to screen
      let boardState = columns[0].map((col, i) => columns.map(row => row[i])).reverse();
      return boardState
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
