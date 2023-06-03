use actix_web::{web, HttpResponse};

#[derive(serde::Deserialize)]
pub struct FormData {
    email: String,
    name: String
}

// subscriptions handler, returns 200 if valid email + name submitted, 400 if either missing/faulty.
// Expects input as application/x-www-form-urlencoded
pub async fn subscribe(_form: web::Form<FormData>) -> HttpResponse {
    HttpResponse::Ok().finish()
}
