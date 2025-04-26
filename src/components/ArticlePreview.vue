<template>
    <div class="article-preview">
        <img v-bind:src="getImgUrl(item.thumbnail.id)" />
        <article>

            <RouterLink :to="{ name: 'post', params: { id: item.id } }">
                <h1>{{ item.title }}</h1>
            </RouterLink>

            <div class="meta-info">
                <div>
                    <span class="author">By {{ item.author.name }}</span>
                    <span class="date">{{ formatDate(item.date_created) }}</span>
                </div>
                <div class="category-container">
                    <div class="category-icon" @click="selectCategory(item.category.name)">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20">
                            <circle cx="12" cy="12" r="10" :fill="getCategoryColor(item.category.name)" />
                        </svg>
                        <span class="tag">{{ item.category.name }}</span>
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
    let origin = window.location.origin;
    let url = origin + '/assets/' + id
    return url
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
    align-items: center;
    /* Allinea meglio il contenuto */
    margin-top: 40px;
    padding: 15px;
    /* Aggiunge un po’ di respiro dentro il box */
    border-radius: 8px;
    /* Smussa leggermente gli angoli per un look più moderno */
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.15);
    /* Ombra più soft e diffusa */
    transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.article-preview:hover {
    transform: translateY(-3px);
    /* Effetto leggero di sollevamento al passaggio del mouse */
    box-shadow: 8px 8px 15px rgba(0, 0, 0, 0.2);
    /* Ombra più marcata in hover */
}


img {
    width: 200px;
    height: 200px;
    object-fit: cover;
    border-radius: 50%;
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
    letter-spacing: 0.15em;
    word-spacing: 0.1em;
    color: var(--primary-color);
    padding-bottom: 5px;
    border-bottom: 2px solid var(--primary-color);
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
    transform: translateY(-3px);
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

    .tag {
        font-size: 0.8em;
    }

}
</style>