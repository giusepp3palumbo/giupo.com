<template>
    <ArticleList :items="items" viewType="preview" />
</template>


<script setup>
import ArticleList from '@/components/ArticleList.vue';
import { onMounted, ref } from 'vue';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

const items = ref([]);
const userStore = useUserStore();

const fetchItems = async () => {

    const response = await fetch('http://localhost:8055/items/posts',
        {
            headers: new Headers({
                'Authorization': 'Basic ' + userStore.accessToken
            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("data")
        console.log(data)
        items.value = data.data;
    }).catch(function (error) {
        console.error('Errore nel recupero dei posts.', error);
    })

    console.log(items.value)
}

// Carica i prodotti quando il componente è montato
onMounted(() => {
    fetchItems();
});
</script>
