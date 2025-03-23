<template>
  <section>
    <h1>Featured Posts</h1>
    <div id="featured-posts">
      <ArticleList :items="items" viewType="card" />
    </div>
  </section>
</template>


<script setup>
import ArticleList from '@/components/ArticleList.vue';
import { onMounted, ref } from 'vue';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

const items = ref([]);
const userStore = useUserStore();

const fetchItems = async () => {

  const response = await fetch('http://localhost:8055/items/posts?filter={ "featured": { "_eq": "true" }}',
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

<style scoped>
#featured-posts {
  display: flex;
  height: 250px;
  gap: 20px;
  justify-content: center;
}

section h1 {
  margin: 0;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  word-spacing: 0.2em;
  color: var(--secondary-color);
  margin: 20px 0;
  border-bottom: 1px solid;
  text-align: center;
}

@media (max-width: 800px) {
  #featured-posts {
    flex-direction: column;
  }
}
</style>