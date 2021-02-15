<template>
  <div id="nav">
    <router-link to="/">
      Home
    </router-link>
    <router-link to="/births">
      Natalicios
    </router-link>
    <button v-if="loggedIn" type="button" class="signOutButton" @click="signOut">
      Cerrar sesión
    </button>
  </div>
</template>

<script>
import { authComputed } from '../vuex/helpers.js'
export default {
  computed: {
    ...authComputed
  },
  methods: {
    signOut () {
      this.$store.dispatch('signOut')
    }
  }
}
</script>

<style scoped>
#nav {
  display: flex;
  align-items: center;
  min-height: 50px;
  padding: 0.2em 1em;
  background: linear-gradient(to right, #16c0b0, #84cf6a);
}

.nav-welcome {
  margin-left: auto;
  margin-right: 1rem;
  color: white;
}

a {
  font-weight: bold;
  color: #2c3e50;
  margin: auto 0.8em auto 0.4em;
  text-decoration: none;
  border-top: 2px solid transparent;
  border-bottom: 2px solid transparent;
}

.router-link-exact-active {
  color: white;
  border-bottom: 2px solid #fff;
}

button, .button {
  margin-left: auto;
  background: white;
  text-decoration: none;
  color: #2c3e50;
}

.router-link-active {
  color: #2c3e50;
}

.signOutButton {
  cursor: pointer;
}

.nav-welcome + button {
  margin-left: 0;
}
</style>
