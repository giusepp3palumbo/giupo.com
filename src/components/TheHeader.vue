<template>
    <header id="page-header">
        <div class="title">
            <h1>Giuseppe Palumbo</h1>
        </div>
        <div class="navbar">
            <nav id="navbar-list" :class="{ 'open': show_menu }">
                <ul>
                    <li>
                        <RouterLink to="/">Home</RouterLink>
                    </li>
                    <li>
                        <RouterLink to="/posts">Blog</RouterLink>
                    </li>
                    <li>
                        <RouterLink to="/projects">Projects</RouterLink>
                    </li>
                    <li>
                        <RouterLink to="/tech-stack">Tech Stack</RouterLink>
                    </li>
                    <li>
                        <RouterLink to="/work">Work</RouterLink>
                    </li>
                    <li>
                        <RouterLink to="/about">About Me</RouterLink>
                    </li>
                </ul>
                <ul>
                    <li>
                        <RouterLink to="/login">Login</RouterLink>
                    </li>
                    <li>
                        <RouterLink to="/register">Sign In</RouterLink>
                    </li>
                </ul>
            </nav>
            <RouterLink id="home-btn" v-if="!show_menu" to="/">
                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                    width="24" height="24" fill="none" viewBox="0 0 24 24">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                </svg>
            </RouterLink>
            <button v-if="!show_menu" v-on:click="showmenu">
                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                    width="24" height="24" fill="none" viewBox="0 0 24 24">
                    <path stroke="currentColor" stroke-linecap="round" stroke-width="2"
                        d="M9 8h10M9 12h10M9 16h10M4.99 8H5m-.02 4h.01m0 4H5" />
                </svg>
            </button>
            <button v-else v-on:click="showmenu">
                <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                    width="24" height="24" fill="none" viewBox="0 0 24 24">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="m5 15 7-7 7 7" />
                </svg>
            </button>
        </div>
    </header>
</template>

<script setup>
import { ref, watch } from 'vue';
import { RouterLink, useRoute } from 'vue-router'

let show_menu = ref(false);
console.log("showMenu start:" + show_menu.value)

function showmenu() {
    console.log("showMenu, old:" + show_menu.value + " / new:" + !show_menu.value)

    show_menu.value = !show_menu.value;
}

const route = useRoute(); // Ottieni l'oggetto route attuale

// Osserva i cambi di route e chiudi il menu
watch(route, () => {
    show_menu.value = false;
});
</script>

<style scoped>
#page-header {
    height: max-content;
}

#page-header h1 {
    font-size: 3rem;
    font-weight: 700;
    letter-spacing: 0.05em;
    text-transform: capitalize;
    font-style: italic;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    /* Effetto rilievo */
    margin: 0 auto;
    padding: 40px 0;
    max-width: 1024px;
}

@media (max-width: 800px) {
    #page-header h1 {
        font-size: 2em;
    }
}


@media (min-width: 801px) {

    #page-header ul {
        margin: 0;
        padding: 20px 0;
        list-style-type: none;
    }

    #page-header li {
        display: inline-block;
        padding-right: 20px;
    }

}


#page-header a {
    padding: 2px 0;
    color: aliceblue;
    text-decoration: none;
    position: relative;
}

#page-header a::after {
    content: '';
    position: absolute;
    left: 0px;
    bottom: 0px;
    width: 100%;
    height: 3px;
    background-color: #fefefe;
    transform-origin: bottom right;
    transition: transform 0.5s ease;
    transform: scaleX(0);
}

#page-header a:hover::after {
    transform-origin: bottom left;
    transform: scaleX(1);
}

#page-header a:active::after {
    transform: scaleY(2);
}

.navbar {
    background-color: var(--primary-color);
    margin: 0;
    padding: 0;
    justify-content: space-between;
    display: flex;
}

.navbar nav {
    margin: auto;
    width: 1024px;
    display: flex;
    justify-content: space-between;
}

button {
    display: none;
    background: none;
    border: none;
}

#home-btn {
    display: none;
}

@media (max-width: 800px) {
    .navbar nav {
        flex-direction: column;
    }

    #home-btn {
        display: block;
    }

    #navbar-list {
        display: none;
    }

    #navbar-list.open {
        display: block;
    }

    ul {
        padding-left: 10px;
    }

    li {
        display: block;
        padding-right: 20px;
    }

    button {
        display: block;
    }
}

svg path {
    stroke: var(--primary-color-light);
}
</style>