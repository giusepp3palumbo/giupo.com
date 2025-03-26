<template>
    <ArticleDetail :postId="postId" />
</template>

<script setup>
import ArticleDetail from '@/components/ArticleDetail.vue';
import { ref } from 'vue';

const postId = ref(7)
console.log("WorkView.vue")
console.log(postId)
</script>