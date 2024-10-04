# Simple Web Application

This is a simple web application using [Python Flask](http://flask.pocoo.org/) and [MySQL](https://www.mysql.com/) database. 
This is used in the demonstration of the development of Ansible Playbooks.
  
  Below are the steps required to get this working on a base linux system.
  
  - **Install all required dependencies**
  - **Install and Configure Web Server**
  - **Start Web Server**
   
## 1. Install all required dependencies
  
  Python and its dependencies
  ```bash
  apt-get install -y python3 python3-setuptools python3-dev build-essential python3-pip default-libmysqlclient-dev
  ```
   
## 2. Install and Configure Web Server

Install Python Flask dependency
```bash
pip3 install flask
pip3 install flask-mysql
```

- Copy `app.py` or download it from a source repository
- Configure database credentials and parameters 

## 3. Start Web Server

Start web server
```bash
FLASK_APP=app.py flask run --host=0.0.0.0
```

## 4. Test

Open a browser and go to URL
```
http://<IP>:5000                            => Welcome
http://<IP>:5000/how%20are%20you            => I am good, how about you?
```




***Project Summary: API Functionality***
This project uses a simple Flask-based API to provide the application's core functionality. The API listens for incoming HTTP requests on port 5000 and responds according to the application's logic. The goal of this API is to create a lightweight service that is readily scaled and deployable in cloud-native environments.

*Containerizing the API*
The API has been containerized with Docker. The Dockerfile specifies an application's environment and dependencies. The container image is created and hosted on DockerHub under the name hackler254/simple-flask-app:latest. This enables consistent deployment across several settings and simplifies the delivery process.

*The CI/CD Process*
The Continuous Integration/Continuous Deployment (CI/CD) process is automated with GitHub Actions. The pipeline is activated with each push to the master branch. The pipeline includes the following steps:

*Checkout Code*: The source code is retrieved from the repository.
Docker Build and Push: The Docker image is created with the Dockerfile and then pushed to DockerHub.
Deployment on Kubernetes: The image is loaded into a Kind cluster (Kubernetes in Docker), and the API is deployed using Kubernetes manifests (app-deployment.yaml).
This pipeline ensures that all code changes are automatically built, containerized, and deployed for testing, increasing efficiency and decreasing human labor.

*Kubernetes deployment*
The API is deployed on Kubernetes via a Deployment resource, which ensures that two replicas of the Flask application execute simultaneously. The application is exposed to external traffic via a Kubernetes Service of type LoadBalancer, which routes traffic from port 80 to Flask's internal port 5000.

The deployment manifest is described as follows:

Deployment: Controls the number of replicas (2) and ensures that the appropriate Docker image (hackler254/simple-flask-app:latest) is utilized.
The Flask application is exposed to external traffic via a LoadBalancer service, which maps external port 80 to internal container port 5000.

*Security Measures*
Several security procedures have been implemented to ensure a safe deployment:

The container uses a read-only root filesystem to prevent unauthorized writes.
Run as Non-Root User: The container operates as a non-root user, reducing the possibility of privilege escalation threats.
Dropped Capabilities: All Linux capabilities are removed, limiting the container's ability to do potentially damaging activities.
These methods follow container security best practices and decrease the application's attack surface.
