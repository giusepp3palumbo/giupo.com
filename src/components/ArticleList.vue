<template>
    <component :is="componentMap[viewType]" v-for="item in items" :key="item.id" :item="item" :authorsMap="authorsMap"
        :categoryMap="categoryMap" @categorySelected="handleCategorySelected" />
</template>

<script setup>
import ArticlePreview from './ArticlePreview.vue';
import ArticleCard from './ArticleCard.vue';

// Mappa dei componenti disponibili
const componentMap = {
    preview: ArticlePreview,
    card: ArticleCard,
};

const props = defineProps(['items', 'authorsMap', 'categoryMap', 'viewType'])
console.log("article.list: " + props.viewType)

const emit = defineEmits(['categorySelected']);

// Propaga l'evento a PostsView.vue
const handleCategorySelected = (categoryName) => {
    emit('categorySelected', categoryName);
};
</script>