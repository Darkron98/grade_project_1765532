const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require( 'swagger-ui-express');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'BLITZ APP API',
      version: '1.0.0',
      description: "## Welcome!\n\nThis is **BLITZ APP**, an academic project presented as a requirement for the degree of system engineering career at Universidad del valle; it consists of a mobile app to manage restaurant home deliveries.\n\n **Author:** *Juan Pablo Parra Rivillas*\n\n**Institution:** Universidad del Valle\n\n**Student code:** 1765532\n\n**career:** 3743 - Systems Engineering\n\n**Contact:** juan.pablo.parra@correounivalle.edu.co",
    },
    servers: [
      {
        url: "https://blitz-api-dev.fly.dev/api/v1",
        description: "Host server"
      },
      {
        url: "http://localhost:8080/api/v1",
        description: "Local server"
      }
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