<template>
  <div>
    <h2>API Info</h2>
    <div v-if="isLoading">Loading</div>
    <div v-else-if="error">{{ error }}</div>
    <div v-else>{{ info }}</div>
  </div>
</template>

<script setup>
import { useQuery } from '@pinia/colada'
import { getAPIInfo } from '@/api/queries'

const {
  data: info,
  isLoading,
  error,
} = useQuery({
  key: ['API-Info'],
  query: getAPIInfo,
})
</script>
