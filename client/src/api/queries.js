import api from '@/api/client'

export async function getAPIHealthcheck() {
  const res = await api.get('/api/health/')
  return res.data
}

export async function getAPIInfo() {
  const res = await api.get('/api/info/')
  return res.data
}
