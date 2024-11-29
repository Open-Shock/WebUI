<template>
  <div v-if="dev" class="dev-header">
    <p>This is the OpenShock <b>DEVELOPMENT</b> environment. <u>No data is saved</u>, and regularly overwritten by production data</p>
  </div>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  beforeMount() {
    this.$store.commit('setDarkMode', utils.isDarkMode());
  },
  watch: {
    '$store.state.settings.dark'(val, old) {
      $('body').attr('data-color-scheme', val ? 'dark' : 'white');
    }
  },
  computed: {
    dev() {
      return config.dev === true || config.dev === 'true';
    }
  }
}
</script>

<style lang="scss">

.dev-header {
  top: 0;
  left: 0;
  right: 0;
  height: 25px;
  background-color: orangered;
  color: #fff;
  text-align: center;
  z-index: 999;
  line-height: 25px;
}

</style>