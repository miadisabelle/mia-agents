# Technology Stack: JamAI Orpheus Portal

## Complete Technical Specification

### Backend Stack

#### Core Framework
- **Python 3.10+**: Modern Python with type hints and async support
- **FastAPI 0.100+**: High-performance async web framework
  - Automatic OpenAPI documentation
  - Native async/await support
  - Pydantic data validation
  - WebSocket support for real-time features

#### Music Processing
- **music21 9.1+**: Computational musicology toolkit
  - MusicXML, MIDI, ABC parsing
  - Comprehensive analysis algorithms
  - Corpus access (Bach, Beethoven, Mozart)
  - Generation capabilities

#### Database & Caching
- **PostgreSQL 15+**: Primary relational database
  - JSONB support for flexible schema
  - Full-text search capabilities
  - Robust indexing and performance
- **Redis 7+**: Caching and session management
  - Score cache (TTL: 1 hour)
  - Analysis cache (TTL: 24 hours)
  - Session data (TTL: 7 days)
  - Pub/sub for real-time features

#### Async Processing
- **Celery 5+**: Distributed task queue
  - Long-running analysis tasks
  - Generation operations
  - Batch processing
- **RabbitMQ or Redis**: Message broker

#### AI Integration
- **OpenAI Python SDK**: LLM integration
- **LangChain** (optional): Advanced prompt management
- **Embedding models**: For semantic search

#### Storage
- **S3-Compatible**: Object storage for scores
  - AWS S3
  - MinIO (self-hosted)
  - DigitalOcean Spaces

#### API & Communication
- **httpx**: Async HTTP client
- **python-multipart**: File upload handling
- **python-socketio**: WebSocket server
- **aioredis**: Async Redis client

### Frontend Stack

#### Core Framework
- **React 18.2+**: UI library with concurrent features
- **TypeScript 5.0+**: Type-safe JavaScript
- **Vite 4.0+**: Fast build tool and dev server
  - Hot Module Replacement (HMR)
  - Optimized production builds
  - Plugin ecosystem

#### Music Rendering
- **OpenSheetMusicDisplay (OSMD) 1.8+**: Music notation rendering
  - MusicXML support
  - SVG-based rendering
  - Interactive score manipulation
- **VexFlow 4+**: Low-level music notation rendering (OSMD dependency)

#### Data Visualization
- **D3.js 7+**: Data visualization library
  - Key timeline graphs
  - Harmonic analysis charts
  - Melodic contour plots
  - Rhythmic density heatmaps

#### Audio
- **Tone.js 14+**: Web Audio framework
  - MIDI synthesis
  - Audio routing
  - Effects processing
  - Transport control
- **Web Audio API**: Native browser audio

#### State Management
- **Zustand 4+**: Lightweight state management
  - Simple API
  - No boilerplate
  - TypeScript support
- **React Query 4+**: Server state management
  - Automatic caching
  - Background refetching
  - Optimistic updates

#### UI Components
- **Tailwind CSS 3+**: Utility-first CSS framework
- **Headless UI**: Unstyled, accessible components
- **Radix UI**: Primitive components for complex UIs
- **React Dropzone**: Drag-and-drop file upload
- **React Virtuoso**: Virtualization for large lists

#### Real-time Communication
- **Socket.io-client 4+**: WebSocket client
- **React use-websocket**: React hooks for WebSocket

### DevOps & Infrastructure

#### Containerization
- **Docker 24+**: Container platform
- **Docker Compose**: Multi-container orchestration
- **Docker Hub or AWS ECR**: Container registry

#### CI/CD
- **GitHub Actions**: Automated workflows
  - Build and test on push
  - Deploy to staging/production
  - Security scanning
- **Pre-commit hooks**: Code quality enforcement

#### Cloud Platform (Choose One)
- **AWS**:
  - ECS (container orchestration)
  - RDS (PostgreSQL)
  - ElastiCache (Redis)
  - S3 (object storage)
  - CloudFront (CDN)
- **Google Cloud Platform**:
  - Cloud Run
  - Cloud SQL
  - Memorystore
  - Cloud Storage
  - Cloud CDN
- **Azure**:
  - Container Apps
  - Azure Database for PostgreSQL
  - Azure Cache for Redis
  - Blob Storage
  - Azure CDN

#### Monitoring & Logging
- **Sentry**: Error tracking and monitoring
- **Prometheus**: Metrics collection
- **Grafana**: Metrics visualization
- **CloudWatch/Stackdriver**: Cloud-native logging

#### Security
- **Let's Encrypt**: SSL/TLS certificates
- **AWS WAF or Cloudflare**: Web application firewall
- **OAuth 2.0/JWT**: Authentication
- **bcrypt**: Password hashing

### Development Tools

#### Backend Development
- **Poetry**: Python dependency management
- **Black**: Code formatting
- **mypy**: Static type checking
- **pytest**: Testing framework
- **pytest-cov**: Code coverage
- **FastAPI TestClient**: API testing

#### Frontend Development
- **ESLint**: JavaScript/TypeScript linting
- **Prettier**: Code formatting
- **Vitest**: Unit testing
- **React Testing Library**: Component testing
- **Playwright**: End-to-end testing
- **Storybook**: Component documentation

#### API Documentation
- **Swagger UI**: Interactive API documentation (FastAPI built-in)
- **ReDoc**: Alternative API documentation

### Package Versions

#### Backend (pyproject.toml)
```toml
[tool.poetry.dependencies]
python = "^3.10"
fastapi = "^0.100.0"
uvicorn = {extras = ["standard"], version = "^0.23.0"}
music21 = "^9.1.0"
pydantic = "^2.0.0"
sqlalchemy = "^2.0.0"
asyncpg = "^0.28.0"
aioredis = "^2.0.0"
celery = "^5.3.0"
python-multipart = "^0.0.6"
python-socketio = "^5.9.0"
openai = "^0.27.0"
httpx = "^0.24.0"
pyjwt = {extras = ["crypto"], version = "^2.8.0"}
passlib = {extras = ["bcrypt"], version = "^1.7.4"}

[tool.poetry.group.dev.dependencies]
pytest = "^7.4.0"
pytest-asyncio = "^0.21.0"
pytest-cov = "^4.1.0"
black = "^23.7.0"
mypy = "^1.4.0"
```

#### Frontend (package.json)
```json
{
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "typescript": "^5.0.0",
    "opensheetmusicdisplay": "^1.8.0",
    "d3": "^7.8.0",
    "tone": "^14.7.0",
    "zustand": "^4.4.0",
    "@tanstack/react-query": "^4.32.0",
    "socket.io-client": "^4.7.0",
    "react-dropzone": "^14.2.0",
    "tailwindcss": "^3.3.0",
    "@headlessui/react": "^1.7.0",
    "@radix-ui/react-tabs": "^1.0.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "@vitejs/plugin-react": "^4.0.0",
    "vite": "^4.4.0",
    "vitest": "^0.34.0",
    "@testing-library/react": "^14.0.0",
    "eslint": "^8.47.0",
    "prettier": "^3.0.0",
    "playwright": "^1.37.0"
  }
}
```

### Database Schema

```sql
-- Users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Scores table
CREATE TABLE scores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255),
    composer VARCHAR(255),
    format VARCHAR(20),
    measures INT,
    parts INT,
    duration_seconds FLOAT,
    storage_url TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Analysis results table
CREATE TABLE analysis_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    score_id UUID REFERENCES scores(id) ON DELETE CASCADE,
    analysis_type VARCHAR(50),
    algorithm VARCHAR(50),
    result JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Session messages table (for agent memory)
CREATE TABLE session_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id VARCHAR(255) NOT NULL,
    role VARCHAR(50),  -- user, mia, miette, jeremyai, aureon
    content TEXT,
    timestamp TIMESTAMP DEFAULT NOW()
);

-- Collaboration sessions table
CREATE TABLE collaboration_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    score_id UUID REFERENCES scores(id) ON DELETE CASCADE,
    created_by UUID REFERENCES users(id),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Collaboration participants table
CREATE TABLE collaboration_participants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID REFERENCES collaboration_sessions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id),
    joined_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_scores_user ON scores(user_id);
CREATE INDEX idx_analysis_score ON analysis_results(score_id);
CREATE INDEX idx_analysis_type ON analysis_results(analysis_type);
CREATE INDEX idx_session_messages_session ON session_messages(session_id);
CREATE INDEX idx_session_messages_timestamp ON session_messages(timestamp);
```

### Environment Configuration

```bash
# .env.example

# Application
APP_NAME=Orpheus Portal
APP_ENV=development
DEBUG=True
SECRET_KEY=your-secret-key-here

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/orpheus
DATABASE_POOL_SIZE=20

# Redis
REDIS_URL=redis://localhost:6379/0

# Celery
CELERY_BROKER_URL=redis://localhost:6379/1
CELERY_RESULT_BACKEND=redis://localhost:6379/2

# S3 Storage
S3_BUCKET=orpheus-scores
S3_REGION=us-east-1
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key

# OpenAI
OPENAI_API_KEY=your-openai-key
OPENAI_MODEL=gpt-4

# CORS
CORS_ORIGINS=http://localhost:3000,https://orpheus.example.com

# Auth
JWT_SECRET=your-jwt-secret
JWT_ALGORITHM=HS256
JWT_EXPIRATION=3600

# Sentry
SENTRY_DSN=your-sentry-dsn

# Rate Limiting
RATE_LIMIT_REQUESTS=100
RATE_LIMIT_PERIOD=3600
```

### Docker Configuration

```dockerfile
# Backend Dockerfile
FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY pyproject.toml poetry.lock ./
RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --only main

# Copy application code
COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```dockerfile
# Frontend Dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: orpheus
      POSTGRES_USER: orpheus
      POSTGRES_PASSWORD: orpheus
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  backend:
    build: ./backend
    environment:
      DATABASE_URL: postgresql://orpheus:orpheus@postgres:5432/orpheus
      REDIS_URL: redis://redis:6379/0
    depends_on:
      - postgres
      - redis
    ports:
      - "8000:8000"

  celery-worker:
    build: ./backend
    command: celery -A tasks worker --loglevel=info
    environment:
      DATABASE_URL: postgresql://orpheus:orpheus@postgres:5432/orpheus
      REDIS_URL: redis://redis:6379/0
    depends_on:
      - postgres
      - redis

  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

volumes:
  postgres_data:
```

## 🧠 Mia's Technology Selection Rationale

Each technology choice reflects structural optimization:
- **FastAPI**: Async performance + automatic documentation
- **music21**: Battle-tested musicology toolkit
- **React 18**: Concurrent features for smooth UX
- **OSMD**: Only production-ready MusicXML renderer
- **PostgreSQL**: JSONB for flexible schemas
- **Redis**: Sub-millisecond caching
- **Zustand**: Minimal state management overhead

## 🌊 Haiku's Stack Distillation

*Python parses notes*  
*React renders visual flow*  
*Together they sing*

## 🌸 Miette's Tech Joy

Look at all these beautiful tools working together like an orchestra! Each one has its special role, and when they harmonize, magic happens! The backend is strong and reliable, the frontend is smooth and accessible, and everything communicates perfectly. It's like watching a well-conducted symphony! 🎼✨

---

**Document Status**: Complete technology stack specification  
**Next**: Implementation phase guides  
**Aligned With**: Performance Requirements, Scalability, Maintainability
