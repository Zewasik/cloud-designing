# cloud-design

This documentation will help you understand the architecture, setup, and usage of the movie streaming platform built using microservices infrastructure.

[Audit questions](https://github.com/01-edu/public/tree/master/subjects/devops/cloud-design/audit)

## Table of Contents

1. [Project Overview](#project-overview)
2. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
3. [API Documentation](#api-documentation)
   - [API Gateway](#api-gateway)
   - [Inventory API](#inventory-api)
   - [Billing API](#billing-api)
4. [EKS](#eks)

## 1. Project Overview <a name="project-overview"></a>

The cloud-design project consists of deploying and managing a microservices-based application on the Amazon Web Services cloud platform. 
The deployment of the app and related services is done via Terraform. App management is implemented by ELK stack.

## 2. Getting Started <a name="getting-started"></a>

### Prerequisites <a name="prerequisites"></a>

Make sure you have the following installed on your machine:

- Terraform 
- AWS account
- AWS CLI

### Installation <a name="installation"></a>

1. Clone the repository:

   ```bash
   git clone https://github.com/Zewasik/cloud-design.git
   ```

2. Navigate to the project directory:

   ```bash
   cd cloud-design
   ```

3. Create the cluster: 

    ```bash
    ./cloud-design.sh create
    ```

4. Update config to allow your user to access the cluster.
    ```bash
    ./cloud-design.sh update-config
    ```

5. Start the cluster: 
    ```bash
    ./cloud-design.sh start
    ```

6. To get the link to the app use: 
    ```bash
    ./cloud-design.sh info elb-hostname
    ```

    - There is interactive documentation located on `/api-docs` endpoint.

7. To delete the deployment use: 
    ```bash
    ./cloud-design.sh stop
    ```

## 3. API Documentation <a name="api-documentation"></a>

### API Gateway <a name="api-gateway"></a>

The API Gateway routes requests between the `Inventory` and `Billing` services. It uses a proxy system to forward requests to the appropriate service. API documentation is available in the OpenAPI format. Refer to `<generated-link>/api-docs` for detailed API documentation.

### Inventory API <a name="inventory-api"></a>

The `Inventory` API is a CRUD RESTful API that provides information about movies. It uses a PostgreSQL database named `movies`. Endpoints include:

- `GET /api/movies`
- `GET /api/movies?title=[name]`
- `POST /api/movies`
- `DELETE /api/movies`
- `GET /api/movies/:id`
- `PUT /api/movies/:id`
- `DELETE /api/movies/:id`

### Billing API <a name="billing-api"></a>

The `Billing` API processes messages received through RabbitMQ. It parses JSON messages and creates entries in the `orders` database. Endpoints include:

- RabbitMQ Queue: `billing_queue`

## 4. EKS <a name="eks"></a>

The project uses EKS to set up all microservices:

- `api-gateway-app`: API Gateway.
- `inventory-app`: `Inventory` API.
- `inventory-database`: Contains the `movies` database.
- `billing-app`: `Billing` API.
- `billing-database`: Contains the `orders` database.
- `rabbitmq`: Runs RabbitMQ service.