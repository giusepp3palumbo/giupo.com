<template>
    <div class="login-container">
        <form class="login-form" method="post" @submit.prevent="login">

            <h1>Login</h1>

            <label for="uname"><b>Username</b></label>
            <input type="text" v-model="username" name="username" placeholder="Username" required>

            <label for="psw"><b>Password</b></label>
            <input type="password" v-model="password" name="password" placeholder="Password" required>

            <button type="submit">Login</button>

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
        let origin = window.location.origin;
        let url = origin + 'items/pages/' + props.postId
        const client = createDirectus(window.location.hostname).with(authentication());
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
.login-container {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    min-height: 100vh;
    padding-top: 10vh;
}

.login-form {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    width: 300px;
    text-align: center;
}

h1 {
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 0.2em;
    word-spacing: 0.2em;
    color: var(--primary-color);
    padding-bottom: 2px;
    border-bottom: 1px solid;
}

label {
    display: block;
    text-align: left;
    margin-top: 10px;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
}


button {
    margin-top: 15px;
    background-color: var(--primary-color);
    color: white;
    border: none;
    border-radius: 5px;
}
</style>