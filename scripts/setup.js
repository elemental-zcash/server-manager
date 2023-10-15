#!/usr/bin/env node

// docker network create -d bridge elemental_net
const fs = require('fs').promises;
const path = require('path');

async function readEnvFile(file, attribute) {
    try {
        const envContent = await fs.readFile(file, 'utf-8');
        const lines = envContent.split('\n');
        
        // Replace 'DB_USER' with the actual environment variable name
        const dbLine = lines.find(line => line.startsWith(`${attribute}=`));
        
        if (dbLine) {
        const value = dbLine.split('=')[1];
        
        return value;
        } else {
        console.log('DB_USER not found in the .env file.');
        }
    } catch (error) {
        console.error('Error reading .env file:', error);
    }
}

const main = async () => {
    const value = await readEnvFile(path.resolve(__dirname, '../.redis.env'), 'REDIS_PSWD');

    console.log(value);
}

main();
  