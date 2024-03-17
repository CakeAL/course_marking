use anyhow::{Ok, Result};
use axum::{routing::any, Router};
use router::course_info::get_course_info_routes;
use router::route_not_found;
use state::AppState;
use util::get_db_connection;

mod dbaccess;
mod handler;
mod entity;
mod router;
mod state;
mod util;

#[tokio::main]
async fn start() -> Result<()> {
    let db_conn = get_db_connection().await?;
    let state = AppState { db_conn };

    let app = Router::new()
        .merge(get_course_info_routes())
        .fallback(any(route_not_found))
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("127.0.0.1:8081").await?;
    axum::serve(listener, app).await?;

    Ok(())
}

pub fn main() {
    let result = start();

    if let Some(err) = result.err() {
        println!("Error: {err}");
    }
}
