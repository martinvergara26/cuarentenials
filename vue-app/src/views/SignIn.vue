<template>
  <div>
    <form @submit.prevent="login">
      <label for="email">
        Email:
      </label>
      <input v-model="email" type="email" name="email" value>

      <label for="password">
        Contraseña:
      </label>
      <input v-model="password" type="password" name="password" value>

      <button type="submit" name="button">
        Iniciar sesión
      </button>

      <p>{{ error }}</p>

      <router-link to="/sign_up">
        ¿No tiene una cuenta? Regístrese.
      </router-link>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      email: '',
      password: '',
      error: null
    }
  },
  methods: {
    login () {
      this.$store
        .dispatch('signIn', {
          email: this.email,
          password: this.password
        })
        .then(() => {
          this.$router.push({ name: 'births' })
        })
        .catch(err => {
          this.error = err.response.data.error
        })
    }
  }
}
</script>

<style scoped>
</style>
