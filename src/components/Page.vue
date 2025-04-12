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
            item.value = data.data[0];  // Assegna i dati del post al ref
            console.log('content:')
            console.log(data.data[0].content)
            try {

                item.value.content = parseHeadings(data.data[0].content);
            } catch (error) {
                console.error('Errore; ', error);
            }
        } else {
            console.error('Page not found: ' + props.slug);
        }
        console.log("item.value:")
        console.log(item.value)
    }).catch(function (error) {
        console.error('Errore nel recupero della pagina.', error);
    })
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