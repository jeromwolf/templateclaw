# TDD Workflow Guide
> Test-Driven Development workflow: Red-Green-Refactor cycle, testing pyramid, and practical patterns
> TDD 워크플로우: Red-Green-Refactor 사이클, 테스팅 피라미드, 실전 패턴

**Category**: Dev Methodology | **Tags**: tdd, testing, red-green-refactor, pytest, jest | **Difficulty**: Intermediate

## Preview
```
RED (Write failing test)
  |
  v
GREEN (Write minimal code to pass)
  |
  v
REFACTOR (Improve code, keep tests green)
  |
  v
REPEAT
```

## Quick Start
```bash
# Python (pytest)
pip install pytest pytest-cov
pytest --cov=src tests/ -v

# JavaScript (Jest)
npm install --save-dev jest
npx jest --coverage

# Run in watch mode during development
pytest --watch  # or: npx jest --watch
```

## The TDD Cycle

### Step 1: RED - Write a Failing Test First

```python
# tests/test_user_service.py
import pytest
from src.user_service import UserService

class TestUserService:
    def setup_method(self):
        self.service = UserService()

    def test_create_user_returns_user_with_id(self):
        user = self.service.create("alice@test.com", "Alice")
        assert user.id is not None
        assert user.email == "alice@test.com"
        assert user.name == "Alice"

    def test_create_user_rejects_duplicate_email(self):
        self.service.create("alice@test.com", "Alice")
        with pytest.raises(ValueError, match="Email already exists"):
            self.service.create("alice@test.com", "Bob")

    def test_create_user_rejects_invalid_email(self):
        with pytest.raises(ValueError, match="Invalid email"):
            self.service.create("not-an-email", "Alice")
```

### Step 2: GREEN - Write Minimal Code to Pass

```python
# src/user_service.py
import re
import uuid
from dataclasses import dataclass

@dataclass
class User:
    id: str
    email: str
    name: str

class UserService:
    def __init__(self):
        self._users: dict[str, User] = {}

    def create(self, email: str, name: str) -> User:
        if not re.match(r"^[^@]+@[^@]+\.[^@]+$", email):
            raise ValueError("Invalid email")
        if email in self._users:
            raise ValueError("Email already exists")
        user = User(id=str(uuid.uuid4()), email=email, name=name)
        self._users[email] = user
        return user
```

### Step 3: REFACTOR - Improve While Tests Stay Green

```python
# Refactored: Extract validation, add type hints
class UserService:
    EMAIL_PATTERN = re.compile(r"^[^@]+@[^@]+\.[^@]+$")

    def __init__(self):
        self._users: dict[str, User] = {}

    def create(self, email: str, name: str) -> User:
        self._validate_email(email)
        self._check_unique(email)
        user = User(id=str(uuid.uuid4()), email=email, name=name)
        self._users[email] = user
        return user

    def _validate_email(self, email: str) -> None:
        if not self.EMAIL_PATTERN.match(email):
            raise ValueError("Invalid email")

    def _check_unique(self, email: str) -> None:
        if email in self._users:
            raise ValueError("Email already exists")
```

## Testing Pyramid

```
        /  E2E  \           Few, slow, expensive
       / -------  \         (Playwright, Selenium)
      / Integration \       Moderate count
     / ------------- \      (API tests, DB tests)
    /    Unit Tests    \    Many, fast, cheap
   /____________________\   (pytest, Jest)
```

| Layer | Count | Speed | What to Test |
|-------|-------|-------|-------------|
| **Unit** | 70-80% | <1ms each | Business logic, pure functions, edge cases |
| **Integration** | 15-20% | <1s each | API endpoints, database queries, external services |
| **E2E** | 5-10% | <30s each | Critical user flows, happy paths only |

## Practical Test Patterns

### Pattern 1: Arrange-Act-Assert (AAA)

```python
def test_discount_applies_to_order():
    # Arrange
    order = Order(items=[Item("Widget", price=100)])
    discount = Discount(percentage=20)

    # Act
    order.apply_discount(discount)

    # Assert
    assert order.total == 80
    assert order.discount_applied is True
```

### Pattern 2: Test Fixtures and Factories

```python
import pytest

@pytest.fixture
def sample_user():
    return User(id="usr_123", email="test@example.com", name="Test User")

@pytest.fixture
def user_service(sample_user):
    service = UserService()
    service._users[sample_user.email] = sample_user
    return service

def test_find_user_by_email(user_service, sample_user):
    found = user_service.find_by_email("test@example.com")
    assert found == sample_user
```

### Pattern 3: Parameterized Tests

```python
@pytest.mark.parametrize("email,valid", [
    ("user@example.com", True),
    ("user@sub.example.com", True),
    ("user+tag@example.com", True),
    ("@example.com", False),
    ("user@", False),
    ("plaintext", False),
    ("", False),
])
def test_email_validation(email, valid):
    if valid:
        assert validate_email(email) is True
    else:
        with pytest.raises(ValueError):
            validate_email(email)
```

### Pattern 4: Mocking External Services

```python
from unittest.mock import patch, MagicMock

def test_send_welcome_email(sample_user):
    with patch("src.email_service.send") as mock_send:
        mock_send.return_value = {"status": "sent"}

        result = onboard_user(sample_user)

        mock_send.assert_called_once_with(
            to=sample_user.email,
            template="welcome",
        )
        assert result.onboarded is True
```

## TDD Rules of Thumb

| Rule | Description |
|------|-------------|
| **One assertion per test** | Test one behavior, not one method |
| **Test behavior, not implementation** | Don't test private methods directly |
| **Name tests descriptively** | `test_expired_coupon_raises_error` not `test_coupon_3` |
| **Keep tests independent** | No shared mutable state between tests |
| **Fast feedback loop** | Unit test suite should run in <10 seconds |
| **Test edge cases** | Empty input, null, boundaries, overflow |
| **Don't test framework code** | Trust that Django ORM or React useState works |

## Customization Guide
- **Language**: Adapt patterns to your stack (Jest for JS, Go testing, Rust #[test])
- **CI integration**: Add `pytest --cov --cov-fail-under=80` to your CI pipeline
- **Coverage target**: Start with 80% line coverage, increase gradually
- **Mutation testing**: Add `mutmut` (Python) or `Stryker` (JS) for deeper quality checks

## 2026 Trend Notes
- Property-based testing (Hypothesis/fast-check) catches edge cases humans miss
- Snapshot testing for API responses and UI components reduces boilerplate
- AI-assisted test generation helps with initial test scaffolding
- Coverage targets are shifting from lines to branches and mutations
- Test containers (testcontainers-python) enable realistic integration tests locally
