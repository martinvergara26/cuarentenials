<template>
  <div>
    <form @submit.prevent="register">
      <label for="email">
        Email:
      </label>
      <input v-model="email" type="email" name="email" value>

      <label for="password">
        Contraseña:
      </label>
      <input v-model="password" type="password" name="password" value>

      <button type="submit" name="button">
        Registrarse
      </button>

      <ul>
        <li v-for="(error, index) in errors" :key="index">
          {{ error }}
        </li>
      </ul>

      <router-link to="/sign_in">
        ¿Ya tiene una cuenta? Iniciar sesión
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
      errors: null
    }
  },
  methods: {
    register () {
      this.$store
        .dispatch('signUp', {
          email: this.email,
          password: this.password
        })
        .then(() => {
          this.$router.push({ name: 'sign_in' })
          alert("Cuenta creada exitosamente. Por favor inicie sesión.")
        })
        .catch(err => {
          this.errors = err.response.data.message
        })
    }
  }
}
</script>

<style scoped>
</style>
