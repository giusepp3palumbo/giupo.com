<template>
    <div>
        <component :is="componentMap[viewType]" v-for="item in items" :key="item.id" :item="item"
            @categorySelected="handleCategorySelected" />
    </div>
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

const emit = defineEmits(['categorySelected']);

// Propaga l'evento a PostsView.vue
const handleCategorySelected = (categoryName) => {
    emit('categorySelected', categoryName);
};
</script>