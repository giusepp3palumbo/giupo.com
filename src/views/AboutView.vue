<template>
  <Page :postId="postId" />
</template>

<script setup>
import Page from '@/components/Page.vue';

const postId = 1
console.log("WorkView.vue")
console.log(postId)
</script>