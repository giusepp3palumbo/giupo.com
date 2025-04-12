<template>
    <Page :slug="slug" />
</template>

<script setup>
import { useRoute } from 'vue-router';  // per accedere ai parametri della route
import { computed } from 'vue';
import Page from '@/components/Page.vue';

const route = useRoute();  // ottieni l'oggetto della route
const slug = computed(() => route.params.slug);  // prendi lo slug dalla URL
console.log("slug:", slug);  // Verifica che lo slug venga passato correttamente
</script>