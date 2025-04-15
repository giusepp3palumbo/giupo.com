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
import { onMounted, ref, watch } from 'vue';
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
    ).then((r) => {
        return r.json();
    }).then((data) => {
        console.log("data***")
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

function parseHeadings(htmlString) {
    console.log("htmlString")
    console.log(htmlString)
    const parser = new DOMParser()
    const doc = parser.parseFromString(htmlString, 'text/html')

    const h2Elements = doc.querySelectorAll('h2')
    console.log("h2Elements")
    console.log(h2Elements)
    const extractedHeadings = []

    h2Elements.forEach((h2, index) => {
        const id = `section-${index}` // Generiamo un ID unico
        h2.setAttribute('id', id) // Aggiungiamo l'ID all'h2
        extractedHeadings.push({ text: h2.textContent, id })
    })

    headings.value = extractedHeadings
    return doc.body.innerHTML // Aggiorniamo il contenuto con gli id nei <h2>
}


watch(() => props.slug, (newSlug) => {
    fetchItem();
});

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

h1 {
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

h2 {
    text-transform: uppercase;
    letter-spacing: 0.2em;
    word-spacing: 0.2em;
    color: var(--primary-color);
    padding-bottom: 2px;
    border-bottom: 1px solid;
}
</style>