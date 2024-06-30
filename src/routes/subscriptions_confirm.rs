use actix_web::{HttpResponse, web};

use serde::Deserialize;

#[derive(Deserialize)]
pub struct Parameters {
    subscription_token: String
}

#[tracing::instrument(
name = "Confirm a pending subscriber",
skip(_parameters)
)]
pub async fn confirm(_parameters: web::Query<Parameters>) -> HttpResponse {
    let confirmation_link = "https://there-is-no-such-domain.com/subscription/confirm";
    HttpResponse::Ok().finish()
}