<template>
    <div id="login-form">
        <form method="post" @submit.prevent="login">

            <h1>Login</h1>

            <label for="uname"><b>Username</b></label>
            <input type="text" v-model="username" name="username" placeholder="Username" required>

            <label for="psw"><b>Password</b></label>
            <input type="password" v-model="password" name="password" placeholder="Password" required>

            <button type="submit" @click="login">Login</button>

        </form>
        <p class="error-text" v-if="error !== ''">Error: {{ error }}</p>
    </div>
</template>


<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

// Ottieni l'istanza del router
const router = useRouter();

// Inizializza lo store di Pinia
const userStore = useUserStore();

// Dichiarazione delle variabili reattive
var username = ref('');
var password = ref('');
var token = ref('')
var error = ref('')

import { createDirectus, authentication } from '@directus/sdk';

async function login(event) {
    try {
        const client = createDirectus('http://localhost:8055').with(authentication());
        console.log(username.value + "/" + password.value)
        token = await client.login(username.value, password.value);
        userStore.setToken(token);
        // Redirect all'utente autenticato
        router.push('/');
    } catch (err) {
        console.log("Error: ")
        console.log(err)
        error.value = err.errors[0].message
    }
}
</script>

<style scoped>
#login-form {
    margin: 10px auto;
    padding: 20px;
    border: 1px solid black;
    border-radius: 5%;
    height: fit-content;
    width: 200px;
}

#login-form form {
    display: flex;
    flex-direction: column;
    margin: 0 0;
}

#login-form h1 {
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 0.2em;
    word-spacing: 0.2em;
    color: var(--primary-color);
    padding-bottom: 2px;
    border-bottom: 1px solid;
}

#login-form label {
    padding-top: 15px;
}

#login-form button {
    margin-top: 15px;
    background-color: var(--primary-color);
    color: white;
    border: none;
    border-radius: 5px;
}
</style>