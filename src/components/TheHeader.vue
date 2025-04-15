<template>
    <header id="page-header">
        <!-- 🔹 DESKTOP HEADER -->
        <div class="page-header-desktop">
            <div>
                <h1>Giuseppe Palumbo</h1>
            </div>
            <div class="navbar">
                <nav id="navbar-list">
                    <ul>
                        <li id="logo-desktop">
                            <RouterLink to="/"><svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                                    viewBox="0 0 24 24">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2"
                                        d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                                </svg> giupo.com</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/posts">Blog</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/tech-stack">Tech Stack</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/page/portfolio">Portfolio</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/page/about-me">About Me</RouterLink>
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
            </div>
        </div>

        <!-- 🔹 MOBILE HEADER -->
        <div class="page-header-mobile">
            <div class="navbar">
                <div id="logo-mobile">
                    <RouterLink to="/">giupo.com</RouterLink>
                </div>
                <!-- hamburger -->
                <button v-if="!show_menu" v-on:click="showmenu">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-width="2"
                            d="M9 8h10M9 12h10M9 16h10M4.99 8H5m-.02 4h.01m0 4H5" />
                    </svg>
                </button>
                <!-- row up -->
                <button v-else v-on:click="showmenu">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="m5 15 7-7 7 7" />
                    </svg>
                </button>
                <RouterLink id="home-btn" v-if="!show_menu" to="/">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                    </svg>
                </RouterLink>
            </div>
            <div class="navbar">
                <nav id="navbar-list-mobile" :class="{ 'open': show_menu }">
                    <ul>
                        <li>
                            <RouterLink to="/posts">Blog</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/tech-stack">Tech Stack</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/page/work-experience">Curriculum</RouterLink>
                        </li>
                        <li>
                            <RouterLink to="/page/about-me">About Me</RouterLink>
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
            </div>
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
/* ------------------------------
   🔹 Base - Header & Titolo
------------------------------ */

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

.page-header-desktop {
    display: block;
}

.page-header-mobile {
    display: none;
}

/* Su mobile nascondi il nome completo */
@media (max-width: 768px) {
    #page-header h1 {
        font-size: 2em;
    }

    .page-header-desktop {
        display: none;
    }

    .page-header-mobile {
        display: block;
    }
}

/* ------------------------------
   🔹 Navbar Layout
------------------------------ */


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

@media (max-width: 800px) {
    .navbar nav {
        flex-direction: column;
    }

    #navbar-list {
        display: none;
    }

    #navbar-list.open {
        display: block;
    }

    #navbar-list-mobile {
        display: none;
    }

    #navbar-list-mobile.open {
        display: block;
    }

    .navbar ul {
        padding-left: 10px;
    }

    .navbar li {
        display: block;
        padding-right: 20px;
    }

}

/* ------------------------------
   🔹 Logo: Mobile e Desktop
------------------------------ */

#logo-desktop {
    display: none;
}

#logo-desktop>a {
    color: var(--primary-color-light) !important;
}

#logo-desktop svg {
    vertical-align: middle;
    margin-right: 5px;
    transform: translateY(-1px);
    /* facoltativo, per fine-tuning */
}

#logo-mobile {
    display: none;
    padding: 10px 15px;
    font-size: 1.5em;
    font-weight: bold;
}

@media (max-width: 768px) {
    #logo-desktop {
        display: none;
        /* nasconde il logo duplicato nel menu */
    }

    #logo-mobile {
        display: block;
    }
}

/* ------------------------------
   🔹 Navigation Links
------------------------------ */

#page-header a {
    padding: 4px 0;
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

@media (min-width: 801px) {

    #page-header ul {
        margin: 0;
        padding: 20px 0;
        list-style-type: none;
    }

    #page-header li {
        display: inline-block;
        padding-right: 30px;
    }

}


/* ------------------------------
   🔹 Button Responsive (Mobile)
------------------------------ */

button {
    display: none;
    background: none;
    border: none;
}

#home-btn {
    display: none;
}

@media (max-width: 800px) {
    button {
        display: block;
    }
}



svg path {
    stroke: var(--primary-color-light);
}
</style>