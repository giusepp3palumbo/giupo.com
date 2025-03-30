<template>
    <div class="article-container">
        <article>
            <h1>{{ item.title }}</h1>
            <main v-html="item.content"></main>
        </article>
    </div>
</template>


<script setup>
import { onMounted, ref } from 'vue';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

const props = defineProps(['postId'])

console.log("props.postId: " + props.postId)

const item = ref([]);
const headings = ref([]) // Array degli <h2> trovati
const parsedContent = ref('') // HTML modificato con gli id nei <h2>

const userStore = useUserStore();

const fetchItem = async () => {

    const response = await fetch('http://localhost:8055/items/pages/' + props.postId,
        {
            headers: new Headers({

            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("data")
        console.log(data)
        item.value = data.data;
        item.value.Content = parseHeadings(data.data.Content);
    }).catch(function (error) {
        console.error('Errore nel recupero dei posts.', error);
    })

    console.log(item.value)
}

// Carica i prodotti quando il componente è montato
onMounted(() => {
    fetchItem();
});

</script>

<style scoped>
.article-container {
    display: flex;
    gap: 50px;
}

article {
    flex: 80%;
}

aside {
    flex: 20%;
    position: sticky;
    top: 20px;
    align-self: start;
}



@media (max-width: 800px) {
    .article-container {
        display: flex;
        flex-direction: column-reverse;
    }

    aside {
        position: relative;
    }
}
</style>