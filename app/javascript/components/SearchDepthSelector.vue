<template>
  <div class="centered">
    <label for="search-depth-selector">Search depth:</label>
    <select
      id="search-depth-selector"
      @change="setSearchDepth">
      <option>1</option>
      <option>2</option>
      <option selected>3</option>
      <option>4</option>
      <option>5</option>
    </select>
  </div>
</template>

<script>

export default {
  props: {
    searchDepth: {
      type: Number,
      required: true,
      validator: function (value) {
        return (value >= 1) || (value <= 5)
      }
    }
  },
  methods: {
    setSearchDepth (e) {
      this.$emit('setSearchDepth', parseInt(e.target.value))
    }
  }
}
</script>

<style scoped>
</style>
