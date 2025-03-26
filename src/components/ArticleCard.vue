<template>
    <div class="article-card">
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
console.log("article.card")
const props = defineProps(['item'])

function getImgUrl(id) {
    return 'http://localhost:8055/assets/' + id
}

</script>

<style scoped>
.article-card {
    width: 300px;
    height: 400px;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.2);
    overflow: hidden;
}

.article-card:hover {
    transform: translateY(-3px);
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease-in-out;
}

img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.content {
    padding: 10px;
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
    border-bottom: 1px solid;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    line-height: 1.4;
    height: 2.8rem;
    padding-bottom: 5px;
}

.summary {
    margin: 0;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 4;
    /* Numero di righe da mostrare */
    -webkit-box-orient: vertical;
    max-height: fit-content;
    /* Altezza massima in base al numero di righe e line-height */
    line-height: 1em;
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