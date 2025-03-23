<script setup>
import ArticleDetail from '@/components/ArticleDetail.vue';
import { useRoute } from 'vue-router'

const route = useRoute()
const postId = route.params.id
console.log("postid: " + postId)
</script>

<template>

    <ArticleDetail :postId="postId" />
</template>
