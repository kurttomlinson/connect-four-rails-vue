<template>
  <div>
    Hello from Vue!
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return {
      moves: []
    }
  },
  props: { gameId: null }
}
</script>

<style scoped>
</style>
