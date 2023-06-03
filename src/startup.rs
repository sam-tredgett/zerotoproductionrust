use actix_web::{web, App,  HttpServer };
use sqlx::PgPool;
use actix_web::dev::Server;
use std::net::TcpListener;
use crate::endpoints::{health_check, subscribe};
 
pub fn run(listener: TcpListener, db_pool: PgPool) -> Result<Server, std::io::Error> {
    let db_pool = web::Data::new(db_pool);
    let server = HttpServer::new(move || { // need to sort out trait implementation
        App::new()
            .route("/health_check", web::get().to(health_check))
            .route("/subscriptions", web::post().to(subscribe))
            .app_data(db_pool.clone())
    })
        .listen(listener)?
        .run();
    Ok(server)
}
