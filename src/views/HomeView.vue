<template>
  <section>
    <h1>Bio</h1>
    <div class="about-me">
      <img v-bind:src="getImgUrl()" alt="Profilo" class="profile-image" />
      <div class="about-text">
        <h2>Ciao, sono Giuseppe! 👋</h2>
        <p>Appassionato di tecnologia, fotografia e sviluppo web. Qui trovi i miei ultimi articoli e progetti.</p>
      </div>
    </div>
  </section>
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
  let origin = window.location.origin;
  let url = origin + '/items/post?filter={ "featured": { "_eq": "true" }}';
  const response = await fetch(url,
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

function getImgUrl() {
  let origin = window.location.origin;
  let url = origin + '/assets/06752b73-d3eb-4e50-a456-6c924d1cc5c0'
  return url
}
</script>

<style scoped>
.about-me {
  display: flex;
  align-items: center;
  background: #f9f9f9;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  margin-bottom: 20px;
}

.profile-image {
  width: 80px;
  height: 100%;
  /* border-radius: 50%;*/
  object-fit: cover;
  margin-right: 15px;
}

.about-text h2 {
  font-size: 1.4rem;
  margin: 0;
}

.about-text p {
  font-size: 1rem;
  color: #555;
  margin-top: 5px;
}

#featured-posts {
  display: flex;
  height: 250px;
  gap: 20px;
  justify-content: center;
}

@media (max-width: 800px) {
  #featured-posts {
    display: flex;
    height: fit-content;
    gap: 20px;
    justify-content: center;
  }
}


section h1 {
  margin: 0;
  font-size: 2rem;
  /* Aumenta la dimensione */
  font-weight: bold;
  text-transform: uppercase;
  letter-spacing: 0.2em;
  word-spacing: 0.2em;
  color: var(--secondary-color);
  margin: 20px 0;
  border-bottom: 2px solid var(--primary-color);
  /* Più spesso e con colore principale */
  text-align: center;
  padding-bottom: 5px;
  /* Per distanziarlo meglio */
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
  /* Leggero effetto 3D */
}

@media (max-width: 800px) {
  #featured-posts {
    flex-direction: column;
  }
}
</style>