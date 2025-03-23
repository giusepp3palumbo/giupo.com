<script setup>
import { RouterView } from 'vue-router'
import TheHeader from './components/TheHeader.vue';
import TheFooter from './components/TheFooter.vue';
</script>

<template>
  <TheHeader />
  <main id="page-main">
    <RouterView />
  </main>
  <TheFooter />
</template>

<style scoped>
@media (min-width: 1024px) {}
</style>
