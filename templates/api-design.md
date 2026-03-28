# REST API Design Guide
> REST API design guide: naming conventions, versioning, pagination, error handling, and OpenAPI spec
> REST API 설계 가이드: 네이밍 컨벤션, 버저닝, 페이지네이션, 에러 처리, OpenAPI 스펙

**Category**: Dev Methodology | **Tags**: api, rest, openapi, pagination, error-handling | **Difficulty**: Intermediate

## Preview
```
GET    /api/v1/users          -> List users (paginated)
GET    /api/v1/users/:id      -> Get single user
POST   /api/v1/users          -> Create user
PATCH  /api/v1/users/:id      -> Update user (partial)
DELETE /api/v1/users/:id      -> Delete user
```

## Quick Start
```bash
# 1. Use this guide as a reference when designing new APIs
# 2. Copy the OpenAPI spec template below and customize
# 3. Apply the error response format consistently across all endpoints
```

## Naming Conventions

### URL Structure

```
https://api.example.com/v1/resources
                         |     |
                    version  plural noun
```

### Rules

| Rule | Good | Bad |
|------|------|-----|
| Use plural nouns | `/users`, `/orders` | `/user`, `/getOrders` |
| Use kebab-case | `/user-profiles` | `/userProfiles`, `/user_profiles` |
| No verbs in URLs | `POST /users` | `/createUser`, `/users/create` |
| Nest for relationships | `/users/123/orders` | `/getUserOrders?userId=123` |
| Use query params for filtering | `/users?role=admin&status=active` | `/users/admin/active` |
| Max 2 levels of nesting | `/users/123/orders` | `/users/123/orders/456/items/789` |

### HTTP Methods

| Method | Purpose | Idempotent | Request Body |
|--------|---------|------------|--------------|
| `GET` | Read resource(s) | Yes | No |
| `POST` | Create resource | No | Yes |
| `PUT` | Replace entire resource | Yes | Yes |
| `PATCH` | Update partial resource | Yes | Yes |
| `DELETE` | Remove resource | Yes | No |

### Status Codes

| Code | Meaning | When to Use |
|------|---------|-------------|
| `200` | OK | GET success, PATCH success |
| `201` | Created | POST success (include Location header) |
| `204` | No Content | DELETE success |
| `400` | Bad Request | Invalid input, validation error |
| `401` | Unauthorized | Missing or invalid auth token |
| `403` | Forbidden | Valid auth but insufficient permissions |
| `404` | Not Found | Resource doesn't exist |
| `409` | Conflict | Duplicate resource, state conflict |
| `422` | Unprocessable | Valid JSON but semantic error |
| `429` | Too Many Requests | Rate limit exceeded |
| `500` | Internal Error | Unexpected server error |

## Pagination

### Cursor-Based (Recommended)

```json
// GET /api/v1/users?limit=20&cursor=eyJpZCI6MTIzfQ

{
  "data": [
    { "id": "usr_124", "name": "Alice", "email": "alice@example.com" },
    { "id": "usr_125", "name": "Bob", "email": "bob@example.com" }
  ],
  "pagination": {
    "next_cursor": "eyJpZCI6MTQ0fQ",
    "has_more": true,
    "limit": 20
  }
}
```

### Offset-Based (Simpler, Less Performant)

```json
// GET /api/v1/users?page=2&per_page=20

{
  "data": [...],
  "pagination": {
    "page": 2,
    "per_page": 20,
    "total": 248,
    "total_pages": 13
  }
}
```

## Error Response Format

### Standard Error Structure

```json
// 400 Bad Request
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address",
        "value": "not-an-email"
      },
      {
        "field": "name",
        "message": "Must be at least 2 characters",
        "value": "A"
      }
    ]
  },
  "request_id": "req_abc123"
}
```

```json
// 404 Not Found
{
  "error": {
    "code": "NOT_FOUND",
    "message": "User with id 'usr_999' not found"
  },
  "request_id": "req_def456"
}
```

```json
// 429 Too Many Requests
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Try again in 30 seconds.",
    "retry_after": 30
  },
  "request_id": "req_ghi789"
}
```

## Versioning

### URL Path Versioning (Recommended)

```
/api/v1/users    # Current version
/api/v2/users    # Breaking changes → new version
```

### When to Bump Version

| Change | Version Bump? |
|--------|--------------|
| Add new optional field to response | No (backward compatible) |
| Add new endpoint | No |
| Remove field from response | **Yes** (breaking) |
| Change field type (string to number) | **Yes** (breaking) |
| Rename endpoint | **Yes** (breaking) |
| Change error format | **Yes** (breaking) |

## OpenAPI Spec Template

```yaml
# openapi.yaml
openapi: "3.1.0"
info:
  title: My API
  version: "1.0.0"
  description: REST API for managing users and resources
  contact:
    name: API Support
    email: support@example.com

servers:
  - url: https://api.example.com/v1
    description: Production
  - url: http://localhost:8000/v1
    description: Local development

paths:
  /users:
    get:
      summary: List users
      operationId: listUsers
      tags: [Users]
      parameters:
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
            maximum: 100
        - name: cursor
          in: query
          schema:
            type: string
        - name: role
          in: query
          schema:
            type: string
            enum: [admin, editor, viewer]
      responses:
        "200":
          description: Paginated list of users
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: "#/components/schemas/User"
                  pagination:
                    $ref: "#/components/schemas/Pagination"

    post:
      summary: Create user
      operationId: createUser
      tags: [Users]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/CreateUserRequest"
      responses:
        "201":
          description: User created
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/User"
        "400":
          $ref: "#/components/responses/BadRequest"
        "409":
          $ref: "#/components/responses/Conflict"

  /users/{id}:
    get:
      summary: Get user by ID
      operationId: getUser
      tags: [Users]
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        "200":
          description: User details
          content:
            application/json:
              schema:
                $ref: "#/components/schemas/User"
        "404":
          $ref: "#/components/responses/NotFound"

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          example: usr_abc123
        email:
          type: string
          format: email
        name:
          type: string
        role:
          type: string
          enum: [admin, editor, viewer]
        created_at:
          type: string
          format: date-time
      required: [id, email, name, role]

    CreateUserRequest:
      type: object
      properties:
        email:
          type: string
          format: email
        name:
          type: string
          minLength: 2
        role:
          type: string
          enum: [admin, editor, viewer]
          default: viewer
      required: [email, name]

    Pagination:
      type: object
      properties:
        next_cursor:
          type: string
          nullable: true
        has_more:
          type: boolean
        limit:
          type: integer

    Error:
      type: object
      properties:
        error:
          type: object
          properties:
            code:
              type: string
            message:
              type: string
            details:
              type: array
              items:
                type: object
        request_id:
          type: string

  responses:
    BadRequest:
      description: Validation error
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/Error"
    NotFound:
      description: Resource not found
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/Error"
    Conflict:
      description: Resource already exists
      content:
        application/json:
          schema:
            $ref: "#/components/schemas/Error"

  securitySchemes:
    BearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

security:
  - BearerAuth: []
```

## Customization Guide
- **Auth**: Change `BearerAuth` to API key, OAuth2, or session-based auth
- **Pagination**: Switch between cursor-based and offset-based based on your needs
- **Error codes**: Define application-specific error codes (e.g., `INSUFFICIENT_BALANCE`)
- **Rate limiting**: Add `X-RateLimit-Limit` and `X-RateLimit-Remaining` headers
- **Versioning**: If you prefer header versioning, use `Accept: application/vnd.api.v1+json`
- **Spec tools**: Use Swagger UI or Redoc to render the OpenAPI spec as interactive docs

## 2026 Trend Notes
- Cursor-based pagination is now preferred over offset for large datasets
- OpenAPI 3.1 aligns with JSON Schema 2020-12 for better validation
- Request IDs in every response (including errors) are essential for debugging
- PATCH with partial updates is preferred over PUT for most update operations
- Rate limit headers in responses help clients self-regulate
