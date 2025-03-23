<template>
    <ArticlePreview v-for="item in items" :key="items.id" :item="item" />
</template>

<script setup>
import ArticlePreview from './ArticlePreview.vue';

const props = defineProps(['items'])
</script>