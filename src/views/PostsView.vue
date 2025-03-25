<template>
    <!-- Mostra la categoria selezionata -->
    <div v-if="selectedCategory" class="filter-info">
        Filtrando per: <strong>{{ selectedCategory }}</strong>
        <button @click="resetFilter">❌ Reset</button>
    </div>

    <ArticleList :items="items" :authorsMap="authorsMap" :categoryMap="categoryMap" viewType="preview"
        @categorySelected="filterByCategory" />
</template>


<script setup>
import ArticleList from '@/components/ArticleList.vue';
import { onMounted, ref, computed } from 'vue';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

const items = ref([]);
const userStore = useUserStore();
const authorsMap = ref({});
const categoryMap = ref({});
const selectedCategory = ref(null);

// Quando si seleziona una categoria, carica i dati filtrati
const filterByCategory = async (category) => {
    selectedCategory.value = category;
    await fetchFilteredItems(category);
};

// Funzione per filtrare i post
const filteredPosts = computed(() => {
    if (!selectedCategory.value) return fetchItems();
    return fetchFiteredItems();
    //return allPosts.value.filter(post => post.category.some(c => c.category_id.name === selectedCategory.value)  );
});

// Funzione per resettare il filtro e ricaricare tutti i post
const resetFilter = async () => {
    selectedCategory.value = null;
    await fetchItems();
};

const fetchItems = async () => {
    const response = await fetch('http://localhost:8055/items/posts?fields=*,*.*.*',
        {
            headers: new Headers({
                'Authorization': 'Basic ' + userStore.accessToken
            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("fetchItems data")
        console.log(data)
        items.value = data.data;
    }).catch(function (error) {
        console.error('Errore nel recupero dei posts.', error);
    })
}

const fetchFilteredItems = async (category) => {
    const response = await fetch(`http://localhost:8055/items/posts?filter[category][category_id][name][_eq]=${category}&fields=*,category.category_id.id,category.category_id.name&limit=-1`,

        {
            headers: new Headers({
                'Authorization': 'Basic ' + userStore.accessToken
            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("fetchItems data")
        console.log(data)
        items.value = data.data;
    }).catch(function (error) {
        console.error('Errore nel recupero dei posts.', error);
    })
}


const fetchAuthor = async () => {
    console.log("fetchAuthor")
    const response = await fetch('http://localhost:8055/items/authors/',
        {
            headers: new Headers({

            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("fetchAuthor data")
        // console.log(data)
        // Crea la mappa ID → Nome autore
        authorsMap.value = data.data.reduce((map, author) => {
            map[author.id] = author.name;
            return map;
        }, {});
    }).catch(function (error) {
        console.error('Errore nel recupero dei authors.', error);
    })
}

const fetchCategory = async () => {
    console.log("fetchAuthor")
    const response = await fetch('http://localhost:8055/items/category?fields=id,name',
        {
            headers: new Headers({

            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("fetchCategory data")
        console.log(data)
        categoryMap.value = data.data.reduce((map, category) => {
            map[category.id] = category.name;
            return map;
        }, {});
    }).catch(function (error) {
        console.error('Errore nel recupero dei category.', error);
    })
}

// Carica i prodotti quando il componente è montato
onMounted(() => {
    fetchAuthor();
    fetchItems();
    fetchCategory();
});
</script>

<style scope>
.filter-info {
    margin-bottom: 10px;
    background: #eee;
    padding: 10px;
    border-radius: 5px;
}

button {
    margin-left: 10px;
    cursor: pointer;
}
</style>