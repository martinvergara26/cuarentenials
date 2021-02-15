<template>
  <div class="home">
    <h1>Bienvenido al sistema</h1>
    <div v-if="!loggedIn">
      <router-link to="/sign_in">
        Iniciar sesión
      </router-link>
      o
      <router-link to="/sign_up">
        Registrarse
      </router-link>
    </div>
  </div>
</template>

<script>
import { authComputed } from '../vuex/helpers.js'
export default {
  computed: {
    ...authComputed
  }
}
</script>
