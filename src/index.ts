import fastify from 'fastify'
import os from 'node:os'

const server = fastify()
server.get('/ping', async (request, reply) => {
  console.log("" + os.hostname)
  return JSON.stringify(request.headers)
})

server.listen({ port: 8080, host:'0.0.0.0' }, (err: Error | null, address: string): void => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
  console.log(`Server listening at ${address}`)
})