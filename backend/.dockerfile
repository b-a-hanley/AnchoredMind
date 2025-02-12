FROM node:22

COPY . .

RUN npm install

CMD ["npm", "run", "start"]