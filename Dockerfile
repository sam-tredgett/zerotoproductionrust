FROM lukemathwalker/cargo-chef:latest-rust-1.65.0 as chef
WORKDIR /app
RUN apt update && apt install lld clang -y 

FROM chef as planner
COPY . . 
# Compute lock-like file for proj
RUN cargo chef prepare --recipe-path recipe.json

# Builder stage
FROM chef AS builder
COPY --from=planner /app/recipe.json recipe.json
# build proj dependencies, not just app
RUN cargo chef cook --release --recipe-path recipe.json
# Dependency tree should be the same at this stage
COPY . .
ENV SQLX_OFFLINE true
RUN cargo build --release --bin zerotoproduction

# Runtime stage
FROM debian:bullseye-slim AS runtime
WORKDIR /app
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    # Clean up
    && apt-get autoremove -y \ 
    && apt-get clean -y \ 
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/release/zerotoproduction zero2prod
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT ["./zero2prod"]
