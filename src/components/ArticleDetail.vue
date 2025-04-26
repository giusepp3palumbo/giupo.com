<template>
    <div class="article-container">
        <article>
            <h1>{{ item.title }}</h1>
            <main v-html="item.content"></main>
        </article>
        <aside v-if="headings.length">
            <h1>On This Page</h1>
            <ul>
                <li v-for="(heading, index) in headings" :key="index">
                    <a :href="'#' + heading.id">{{ heading.text }}</a>
                </li>
            </ul>
        </aside>
    </div>
</template>


<script setup>
import { onMounted, ref, nextTick } from 'vue';
import { useUserStore } from '@/stores/userStore'; // Importa lo store

const props = defineProps(['postId'])

console.log("props.postId: " + props.postId)

const item = ref([]);
const headings = ref([]) // Array degli <h2> trovati
const parsedContent = ref('') // HTML modificato con gli id nei <h2>

const userStore = useUserStore();

function decodeHtml(html) {
    const txt = document.createElement('textarea');
    txt.innerHTML = html;
    return txt.value;
}

const fetchItem = async () => {
    let origin = window.location.origin;
    let url = origin + '/items/post/' + props.postId
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
        item.value = data.data;
        item.value.content = decodeHtml(parseHeadings(data.data.content));
    }).catch(function (error) {
        console.error('Errore nel recupero dei posts.', error);
    })

    console.log(item.value)

    // Aspetta che Vue aggiorni il DOM
    await nextTick()

    // Poi fai l'highlight
    if (window.Prism) {
        Prism.highlightAll()
    } else {
        console.error('Prism non è caricato!')
    }
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

aside ul {
    margin: 0;
    padding: 20px 0;
    list-style-type: "\1F7C5";
}

aside li {
    padding-left: 5px;
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