<template>
  <div id="app">
    <app-nav />
    <router-view class="page" />
  </div>
</template>

<script>
import AppNav from './components/AppNav'

export default {
  components: { AppNav },
  created() {
    const userString = localStorage.getItem('user');
    if(userString){
      const data = JSON.parse(userString)
      const authToken = JSON.parse(localStorage.getItem('authToken'))
      this.$store.commit('SET_USER_DATA', {data, authToken})
    }
  }
}
</script>

<style>
@import './assets/styles/global.css';
.page {
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
  min-height: calc(100vh - 56px);
}
</style>
