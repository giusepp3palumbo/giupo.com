<template>
    <div class="article-container" v-if="item">
        <article>
            <h1>{{ item.title }}</h1>
            <main v-html="item.content"></main>
        </article>
    </div>
    <div v-else>
        <p>Loading...</p>
    </div>
</template>


<script setup>
import { onMounted, ref } from 'vue';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

const props = defineProps(['slug'])

const item = ref(null);
const headings = ref([]) // Array degli <h2> trovati
const parsedContent = ref('') // HTML modificato con gli id nei <h2>

const userStore = useUserStore();

const fetchItem = async () => {
    let origin = window.location.origin;
    let url = origin + `/items/page?filter[slug][_eq]=${props.slug}`
    const response = await fetch(url,
        {
            headers: new Headers({

            })
        }
    ).then((response) => {
        return response.json();
    }).then((data) => {
        console.log("data")
        console.log(data)

        if (data.data.length > 0) {
            item.value = response.data.data[0];  // Assegna i dati del post al ref
        } else {
            console.error('Page not found: ' + props.slug);
        }
        item.value.content = parseHeadings(item.value.content);
    }).catch(function (error) {
        console.error('Errore nel recupero della pagina.', error);
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