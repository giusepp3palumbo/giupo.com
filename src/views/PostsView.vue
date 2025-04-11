<template>



    <!-- Mostra la categoria selezionata -->
    <div v-if="selectedCategory" class="filter-info">
        <p>Filtrando per: <strong>{{ selectedCategory }}</strong></p>

        <svg @click="resetFilter" style="cursor: pointer;" class="w-6 h-6 text-gray-800 dark:text-white"
            aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
            viewBox="0 0 24 24">
            <path stroke="red" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M6 18 17.94 6M18 18 6.06 6" />
        </svg>

    </div>

    <!-- Mostra la lista di articoli -->
    <ArticleList :items="items" viewType="preview" @categorySelected="filterByCategory" />
    <!-- Mostra la paginazione -->
    <div class="pagination">
        <svg :class="{ disabled: currentPage === 1 }" @click="fetchItems(currentPage - 1)"
            class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
            width="24" height="24" fill="none" viewBox="0 0 24 24">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="m17 16-4-4 4-4m-6 8-4-4 4-4" />
        </svg>
        <span>Pagina {{ currentPage }} di {{ totalPages }}</span>
        <svg :class="{ disabled: currentPage >= totalPages }" @click="fetchItems(currentPage + 1)"
            class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
            width="24" height="24" fill="none" viewBox="0 0 24 24">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="m7 16 4-4-4-4m6 8 4-4-4-4" />
        </svg>
    </div>
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
const currentPage = ref(1);
const perPage = 2; // Numero di elementi per pagina
const totalPages = ref(null);

// Quando si seleziona una categoria, carica i dati filtrati
const filterByCategory = async (category) => {
    selectedCategory.value = category;
    await fetchItems();
};

// Funzione per filtrare i post
const filteredPosts = computed(() => {
    return fetchItems();
    //return allPosts.value.filter(post => post.category.some(c => c.category_id.name === selectedCategory.value)  );
});

// Funzione per resettare il filtro e ricaricare tutti i post
const resetFilter = async () => {
    selectedCategory.value = null;
    await fetchItems();
};

const fetchItems = async (page = 1) => {
    let origin = window.location.origin;
    let url = origin + '/items/posts';
    if (selectedCategory.value) {
        url += `?page=${page}&limit=${perPage}&meta=*&filter[category][category_id][name][_eq]=${selectedCategory.value}&fields=*,category.category_id.id,category.category_id.name`;
    } else {
        url += `?page=${page}&limit=${perPage}&meta=*&fields=*,*.*.*`
    }

    const response = await fetch(url,
        {
            headers: new Headers({

            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("fetchItems data")
        console.log(data)
        items.value = data.data;
        currentPage.value = page;
        totalPages.value = Math.ceil(data.meta.filter_count / perPage);
        console.log("currentPage: " + currentPage.value + ", totalPages:" + totalPages.value)
    }).catch(function (error) {
        console.error('Errore nel recupero dei posts.', error);
    })
}


const fetchAuthor = async () => {
    console.log("fetchAuthor")
    let origin = window.location.origin;
    let url = origin + '/items/authors/';
    const response = await fetch(url,
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
    let origin = window.location.origin;
    let url = origin + '/items/category?fields=id,name';
    const response = await fetch(url,
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
    background: #f9f9f9;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    display: flex;
    justify-content: space-between;
}

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 5px;
    gap: 10px;
    margin-top: 20px;
}

p {
    margin: 0;
    padding: 3px;
}

.pagination svg {
    background-color: var(--primary-color);
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 4px;
}

.disabled {
    background-color: gray;
    cursor: not-allowed;
    pointer-events: none;
}
</style>