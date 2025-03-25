<template>
    <div class="article-preview">
        <img v-bind:src="getImgUrl(item.thumbnail)" />
        <article>

            <RouterLink :to="{ name: 'post', params: { id: item.id } }">
                <h1>{{ item.title }}</h1>
            </RouterLink>

            <div class="meta-info">
                <div>
                    <span class="author">By {{ item.author.name }}</span>
                    <span class="date">{{ formatDate(item.created_at) }}</span>
                </div>
                <div class="category-container">
                    <div class="category-icon" v-for="c in item.category" @click="selectCategory(c.category_id.name)">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20">
                            <circle cx="12" cy="12" r="10" :fill="getCategoryColor(c.category_id.name)" />
                        </svg>

                        <span class="first-letter">{{ c.category_id.name.charAt(0) }}</span>
                        <span class="category-text">{{ c.category_id.name.slice(1) }}</span>
                    </div>
                </div>
            </div>
            <p class="summary" v-html="item.summary"></p>
        </article>
    </div>
</template>

<script setup>
const emit = defineEmits(['categorySelected']);
const props = defineProps(['item'])

function getImgUrl(id) {
    return 'http://localhost:8055/assets/' + id
}

function formatDate(date) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(date).toLocaleDateString(undefined, options);
}

const categoryColors = {
    "tech": "#630000",
    "photo": "#006e5d",
};

// Funzione per ottenere il colore
const getCategoryColor = (name) => {
    return categoryColors[name] || "#ccc"; // Default grigio se non è definito
};

// Funzione per emettere l'evento con la categoria selezionata
const selectCategory = (categoryName) => {
    emit('categorySelected', categoryName);
};
</script>

<style scoped>
.article-preview {

    display: flex;
    margin-top: 40px;
    box-shadow: 5px 5px 5px var(--primary-color-darker);
}

img {
    width: 200px;
    height: 200px;
    object-fit: cover;
}

article {
    display: flex;
    flex-direction: column;
    margin: 0 20px;
    max-height: 100%;
    width: 100%;
}

a {
    text-decoration: none;
}

h1 {
    display: block;
    width: 100%;
    margin: 0;
    text-transform: uppercase;
    letter-spacing: 0.2em;
    word-spacing: 0.2em;
    color: var(--primary-color);
    padding-bottom: 2px;
    border-bottom: 1px solid;
}

.meta-info {
    font-size: 0.9rem;
    color: gray;
    margin-top: 10px;
    display: flex;
    justify-content: space-between;
}

.meta-info .author,
.meta-info .date {
    display: inline-block;
    margin-right: 15px;
}

.category-container {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
}

.category-icon {
    display: flex;
    align-items: center;
    gap: 2px;
    background-color: var(--info-color);
    color: white;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

.category-icon:hover {
    background-color: var(--secondary-color);
    box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.3);
    transform: scale(1.05);
}

.first-letter {
    font-weight: bold;
    text-transform: capitalize;
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