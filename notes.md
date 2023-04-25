```sh
git rev-parse --short=7 refs/heads/example-branch-name
```

```yml
version: "3.8"

services:
  {{ serviceName }}:
    image: "{{ image }}"
    container_name: "{{ containerName }}"
    restart: always
    ports:
      - "{{ externalPort }}:{{ internalPort }}"
    environment:
      - NODE_ENV={{ env }}
    volumes:
      - "{{ volume }}"
```

```js
const fs = require('fs');
const template = fs.readFileSync('docker-compose.yml.template', 'utf-8');

const data = {
  serviceName: 'my-app',
  image: 'my-registry/my-app:latest',
  containerName: 'my-app-container',
  externalPort: 8080,
  internalPort: 3000,
  env: 'production',
  volume: '/my-app/data:/app/data'
};

const output = nunjucks.renderString(template, data);

fs.writeFileSync('docker-compose.yml', output);
```

