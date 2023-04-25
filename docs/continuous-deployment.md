# Continuous Deployment

Here are the general steps to create a separate deployment user in Debian with access to Docker and only able to run specific commands:

1. Create a new user using the `adduser` command. For example, to create a new user named `deploy`, run:

```sh
sudo adduser deploy
```

2. Add the new user to the `docker` group to allow access to Docker commands. Run the following command:

```sh
sudo usermod -aG docker deploy
```

3. Create a new directory where you can store your deployment scripts. For example, you can create a new directory named `/deploy`:

```sh
sudo mkdir /deploy
```

4. Change the ownership of the `/deploy` directory to the `deploy` user:

```sh
sudo chown deploy:deploy /deploy
```

5. Create a new script in the `/deploy` directory that contains the specific commands you want the `deploy` user to be able to run. For example, you can create a script named `deploy.sh` that contains the following commands:

```sh
#!/bin/bash

# Pull the latest Docker image
docker pull your-image:latest

# Stop the current Docker container
docker stop your-container

# Remove the current Docker container
docker rm your-container

# Start a new Docker container
docker run --name your-container -d your-image:latest
```

6. Make the `deploy.sh` script executable by running:

```sh
sudo chmod +x /deploy/deploy.sh
```

7. Restrict the `deploy` user to only be able to run the `deploy.sh` script by creating a new shell that runs only that script when the user logs in. To do this, edit the `deploy` user's `authorized_keys` file by running:

```sh
sudo vim /home/deploy/.ssh/authorized_keys
```

8. Add the following line to the file, replacing `/deploy/deploy.sh` with the path to your `deploy.sh` script:

```
command="/deploy/deploy.sh" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQ[...]
```

This will restrict the user to only be able to run the `deploy.sh` script when they log in.

9. Save and exit the `authorized_keys` file.

That's it! The `deploy` user will now be able to log in via SSH and run the `deploy.sh` script using the restricted shell.
