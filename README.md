# Building and Deploying a Secure Flask App with Nginx and Gunicorn on Minikube
This README provides a step-by-step guide on how to deploy and test a secure Flask web application using Nginx as a reverse proxy and Gunicorn as the application server on a Minikube cluster while emphasizing security best practices, including using a non-root user in the Dockerfile, minimizing image size, and implementing SSL/TLS encryption.

## NGINX and Gunicorn Integration                                                                   
 To enhance the performance and reliability of the application, NGINX and Gunicorn have been integrated into the project. NGINX acts as a reverse proxy server, forwarding requests to Gunicorn, which serves the application. This setup provides benefits such as load balancing, improved security, and better handling of client connections.
 ![nginx_gunicorn](https://github.com/shmuelSigler/Dcoya_DevOps/blob/main/gninx_gunicorn.png?raw=true)

 #### [NGINX Configuration](https://github.com/shmuelSigler/Dcoya_DevOps/blob/main/nginx-config.conf)                                                                             
The NGINX configuration plays a significant role in directing incoming traffic to the appropriate backend servers. In my project, NGINX is set up as a reverse proxy, which means it receives client requests and forwards them to the Gunicorn instances running the Python application. Let's take a closer look at the key components of NGINX's configuration:

                  
  - **limit_req_zone and limit_conn_zone**: These directives define rate limiting and connection limiting zones to manage the rate at which clients can access the application. <ins>This helps prevent abuse and ensures fair usage.</ins>
  - **Reverse Proxy**: Nginx acts as a reverse proxy for the application exposed on Kubernetes service dcoya-svc:5000. Requests to the server are forwarded to application's backend, <ins>enhancing security by hiding the backend server details.</ins>
  - **SSL/TLS**: SSL certificate and private key are specified for secure communication. HTTP to HTTPS Redirection, <ins>This ensures that all traffic is encrypted and secure.</ins>

  
 ## [Dockerfile](https://github.com/shmuelSigler/Dcoya_DevOps/blob/main/app/Dockerfile)        
 Dockerfile enhances security by using:
 - Minimal Alpine base image
 - Copying only necessary files and reducing image size
 - Avoiding the generation of Python bytecode files within the container
 - Running the application as a non-root user

These practices collectively reduce the attack surface and follow best security practices for Docker containerization.

 ## Run Locally

Before you begin, ensure you have the following prerequisites installed:

- Docker
- kubectl
- Minikube
- Python 3 
- To run this project, you will need to add the following environment variables to your .env file in app directory `HOST_NAME`

Clone the project

```bash
  git clone https://github.com/shmuelSigler/Dcoya_DevOps.git
```

Go to the project directory

```bash
  cd Dcoya_DevOps
```

Run script that automates the deployment process 

```bash
  source run_app.sh
```

Test the application

```bash
  python3 app/test.py
```

#### Minikube Deployment Automation Script
The script streamlines the deployment process on a Minikube cluster, reducing manual intervention. It starts by initializing Minikube, setting up a local Kubernetes cluster where the application will run. This automation saves time and ensures a consistent deployment environment.

- **Configuration Management and TLS Security**: The script creates a ConfigMap to manage the Nginx configuration centrally, making it easier to maintain. Additionally, it generates a TLS secret using SSL/TLS certificates. 

- **Resource Monitoring and Waiting**: Before proceeding, the script ensures that the deployed resources become available. 

- **Minikube Tunnel for External Access**: The script starts Minikube Tunnel in a separate terminal. This is vital for accessing services exposed with a LoadBalancer type externally within Minikube.

- **User-Friendly and Convenient**: To enhance usability, the script exports an environment variable (APP_URL) with the external IP address of the application making it convenient for quick testing by just running the test script. Furthermore, the script opens the application on default web browser for quick access.

