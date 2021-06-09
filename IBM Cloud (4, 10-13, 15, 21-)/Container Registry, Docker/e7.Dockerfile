FROM node:10

ADD frontend-example-docker /app
WORKDIR /app
EXPOSE 5000

RUN npm install
RUN npm run build
CMD ["npm", "start"]