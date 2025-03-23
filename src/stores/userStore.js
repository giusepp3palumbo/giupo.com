import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    accessToken: null,
  }),
  actions: {
    setToken(token) {
      this.accessToken = token
    },
    // Resetta lo stato (logout)
    clearState() {
      this.$reset()
    },
  },
  getters: {
    isLoggedIn: (state) => !!state.accessToken, // Ritorna true se l'utente è loggato
  },
  // Configura la persistenza
  persist: {
    enabled: true, // Abilita la persistenza
    strategies: [
      {
        key: 'userStore', // Nome della chiave in localStorage/sessionStorage
        storage: localStorage, // Usa localStorage o sessionStorage
      },
    ],
  },
})
