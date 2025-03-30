<template>
  <Page :postId="postId" />
</template>

<script setup>
import Page from '@/components/Page.vue';

const postId = 2
console.log("WorkView.vue")
console.log(postId)
</script>