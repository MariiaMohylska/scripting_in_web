#!/bin/bash
cd example-app-nodejs-backend-react-frontend
node install
duration_start_yarn=$(date +%s)
yarn install
yarn run build
pm2 --name ExampleNodeJS start yarn -- start
pkill -f node
duration_end_yarn=$(date +%s)
yarn cache clean
rm package-lock.json

node install
duration_start_npm=$(date +%s)
npm install
npm run build
pm2 --name ExampleNodeJS start npm -- start 
duration_end_npm=$(date +%s)
sudo pkill -f node 
npm cache clean
rm package-lock.json

pm2 delete all

time_npm=$((duration_end_npm - duration_start_npm))
time_yarn=$((duration_end_yarn  - duration_start_yarn))

echo "NPM: $time_npm  | YARN: $time_yarn"
