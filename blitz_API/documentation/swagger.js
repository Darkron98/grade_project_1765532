const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require( 'swagger-ui-express');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'BLITZ APP API',
      version: '1.0.0',
    },
    servers: [
      {
        url: "http://localhost:8080/api/v1",
        description: "Local server"
      },
      {
        url: "https://blitz-api-dev.fly.dev/api/v1",
        description: "Host server"
      },
    ]
  },
  // looks for configuration in specified directories
  apis: ['./v1/routes/*.js','./documentation/components.yaml'],
}

const swaggerSpec = swaggerJsdoc(options);

function swaggerDocs(app, port) {
  // Swagger Page
  app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec, { explorer: true, customCss: '.swagger-ui .topbar { display: none }', customJs: '/no-cache.js' }))
  // Documentation in JSON format
  app.get('/docs.json', (req, res) => {
    res.setHeader('Content-Type', 'application/json')
    res.send(swaggerSpec)
  });
}

module.exports ={
  swaggerDocs
}