<template>
  <div>
    <h2>API Health</h2>
    <div v-if="isLoading">Loading</div>
    <div v-else-if="error">{{ error }}</div>
    <div v-else>{{ status }}</div>
  </div>
</template>

<script setup>
import { useQuery } from '@pinia/colada'
import { getAPIHealthcheck } from '@/api/queries'

const {
  data: status,
  isLoading,
  error,
} = useQuery({
  key: ['health-check'],
  query: getAPIHealthcheck,
})
</script>
