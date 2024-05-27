use actix_web::HttpResponse;

// Health check handler, returns OK if app running
pub async fn health_check() -> HttpResponse {
    HttpResponse::Ok().finish()
}
