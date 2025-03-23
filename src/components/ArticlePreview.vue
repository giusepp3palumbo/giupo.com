<template>
    <div class="article-preview">
        <img v-bind:src="getImgUrl(item.thumbnail)" />
        <article>

            <RouterLink :to="{ name: 'post', params: { id: item.id } }">
                <h1>{{ item.title }}</h1>
            </RouterLink>

            <p class="summary" v-html="item.summary"></p>
        </article>
    </div>
</template>

<script setup>
const props = defineProps(['item'])

function getImgUrl(id) {
    return 'http://localhost:8055/assets/' + id
}

</script>

<style scoped>
.article-preview {
    display: flex;
    height: 200px;
    margin-top: 40px;
    box-shadow: 5px 5px 5px var(--primary-color-darker);
}

img {
    width: 200px;
    height: 200px;
}

article {
    display: flex;
    flex-direction: column;
    margin: 0 20px;

}

a {
    text-decoration: none;
}

article h1 {
    margin: 0;
    text-transform: uppercase;
    letter-spacing: 0.2em;
    word-spacing: 0.2em;
    color: var(--primary-color);
    padding-bottom: 2px;
    border-bottom: 1px solid;
}

.summary {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    /* Numero di righe da mostrare */
    -webkit-box-orient: vertical;
    max-height: 6em;
    /* Altezza massima in base al numero di righe e line-height */
    line-height: 1.5em;
    /* Assicurati che sia coerente con max-height */
    white-space: normal;
    /* Necessario per il multi-line truncation */
}

@media (max-width: 800px) {
    .article-preview {
        height: fit-content;
        display: flex;
        margin-top: 40px;
        flex-direction: column;
        gap: 0;
        box-shadow: 5px 5px 5px var(--primary-color-darker);
    }

    img {
        display: none;
    }

}
</style>