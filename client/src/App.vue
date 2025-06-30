<template>
  <RouterView />
  <PiniaColadaDevtools />
</template>

<script setup>
import { RouterView } from 'vue-router'
import { PiniaColadaDevtools } from '@pinia/colada-devtools'
</script>
