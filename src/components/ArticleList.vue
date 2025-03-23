<template>
    <component :is="componentMap[viewType]" v-for="item in items" :key="item.id" :item="item" />
</template>

<script setup>
import ArticlePreview from './ArticlePreview.vue';
import ArticleCard from './ArticleCard.vue';

// Mappa dei componenti disponibili
const componentMap = {
    preview: ArticlePreview,
    card: ArticleCard,
};

const props = defineProps(['items', 'viewType'])
console.log("article.list: " + props.viewType)
</script>