<template>
    <div class="article-card">
        <img v-bind:src="getImgUrl(item.thumbnail)" />
        <article>

            <RouterLink :to="{ name: 'post', params: { id: item.id } }">
                <h1>{{ item.title }}</h1>
            </RouterLink>

            <!-- <p class="summary" v-html="item.summary"></p>-->
        </article>
    </div>
</template>

<script setup>
console.log("article.card")
const props = defineProps(['item'])

function getImgUrl(id) {
    let origin = window.location.origin;
    return origin + '/assets/' + id
}

</script>

<style scoped>
.article-card {
    width: 300px;
    height: fit-content;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.2);
    overflow: hidden;
}

@media (max-width: 800px) {
    .article-card {
        width: 100%;
        box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.2);
    }

    article {
        display: flex;
        height: fit-content;
        flex-direction: column;
        margin: 0 10px;
    }
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

@media (max-width: 800px) {
    img {
        width: 100%;
        height: 100px;
        object-fit: cover;
    }
}

.content {
    padding: 10px;
}

a {
    text-decoration: none;
}

@media (min-width: 800px) {
    article h1 {
        margin: 0;
        text-transform: uppercase;
        color: var(--primary-color);
        border-bottom: none;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 5;
        word-break: break-word;
        overflow-wrap: break-word;
        line-height: 1.4;
        height: 6.8rem;
        padding-bottom: 5px;
        font-size: 0.8em;
    }
}


@media (max-width: 800px) {
    article h1 {
        height: fit-content;
        margin: 0;
        text-transform: uppercase;
        color: var(--primary-color);
        border-bottom: none;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 5;
        word-break: break-word;
        overflow-wrap: break-word;
        line-height: 1.4;

        padding-bottom: 5px;
        font-size: 0.8em;
    }
}

.summary {
    padding-top: 20px;
    margin: 0;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 5;
    line-height: 1.5em;
    height: 7.5rem;
    white-space: normal;
}
</style>