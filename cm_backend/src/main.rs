use anyhow::{Ok, Result};
use axum::{routing::any, Router};
use router::course_info::get_course_info_routes;
use router::route_not_found;
use state::AppState;
use util::get_db_connection;

mod dbaccess;
mod handler;
mod model;
mod router;
mod state;
mod util;

#[tokio::main]
async fn start() -> Result<()> {
    let db_conn = get_db_connection().await?;
    let state = AppState { db_conn };

    let app = Router::new()
        .merge(get_course_info_routes())
        .with_state(state)
        .fallback(any(route_not_found));

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
