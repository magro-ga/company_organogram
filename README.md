# CompanyOrganogram

CompanyOrganogram is a Ruby on Rails application designed to manage and visualize the organizational structure of a company. It allows you to create companies, add employees, and define hierarchical relationships between them.

## Ruby Version

- Ruby 3.0.0

## System Dependencies

- Rails 8.0.1
- SQLite3
- Puma
- Bootsnap
- GraphQL

## Configuration

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/company_organogram.git
   cd company_organogram

# Project Setup and API Documentation

## Install the Required Gems

Ensure you have all necessary gems installed by running:

```sh
bundle install
```

## Set Up the Database

### Database Creation
The database is created using SQLite3. To create the database, run:

```sh
rails db:create
```

### Database Initialization
To initialize the database with the necessary tables and seed data, run:

```sh
rails db:migrate
rails db:seed
```

## How to Run the Test Suite
To run the test suite, use:

```sh
bundle exec rspec
```

## Services
- **Job Queues**: Not implemented
- **Cache Servers**: Not implemented
- **Search Engines**: Not implemented

## Deployment Instructions
To deploy the application, follow these steps:

1. Ensure all dependencies are installed:
   ```sh
   bundle install
   ```
2. Set up the database on the production server:
   ```sh
   rails db:create db:migrate db:seed
   ```
3. Precompile assets:
   ```sh
   rails assets:precompile
   ```
4. Start the server:
   ```sh
   rails server
   ```

## API Endpoints

### Companies
- **GET** `/api/v1/companies` - List all companies
- **GET** `/api/v1/companies/:id` - Show a specific company
- **POST** `/api/v1/companies` - Create a new company

### Employees
- **GET** `/api/v1/employees` - List all employees
- **GET** `/api/v1/companies/:company_id/employees` - List employees of a specific company
- **GET** `/api/v1/employees/:id` - Show a specific employee
- **POST** `/api/v1/companies/:company_id/employees` - Create a new employee in a specific company
- **PUT** `/api/v1/employees/:id` - Update a specific employee
- **DELETE** `/api/v1/employees/:id` - Delete a specific employee
- **GET** `/api/v1/employees/:id/peers` - List peers of a specific employee
- **GET** `/api/v1/employees/:id/direct_reports` - List direct reports of a specific employee
- **GET** `/api/v1/employees/:id/second_level_reports` - List second-level reports of a specific employee

---

## GraphQL API

### Endpoints
- `POST /api/v2/graphql` - Main GraphQL entry point
- `GET /graphiql` - Interactive GraphQL UI (only in development mode)

### Queries
#### Fetch Companies
```graphql
query {
  companies {
    id
    name
    employees {
      id
      name
      email
    }
  }
}
```

#### Fetch Employees
```graphql
query {
  employees {
    id
    name
    email
  }
}
```

#### Fetch Employee Peers
```graphql
query {
  employee(id: 1) {
    id
    name
    peers {
      id
      name
    }
  }
}
```

### Mutations
#### Create Company
```graphql
mutation {
  createCompany(name: "New Company") {
    id
    name
  }
}
```

#### Create Employee
```graphql
mutation {
  createEmployee(companyId: 1, name: "John Doe", email: "john@example.com") {
    id
    name
    email
  }
}
```

#### Update Employee
```graphql
mutation {
  updateEmployee(id: 1, name: "Updated Name", email: "updated@example.com") {
    id
    name
    email
  }
}
```

#### Delete Employee
```graphql
mutation {
  deleteEmployee(id: 1)
}
```

