use anyhow::{Ok, Result};
use axum::{routing::any, Router};
use router::course_info::*;
use router::route_not_found;
use state::AppState;
use util::get_db_connection;
use tower_http::trace::{self, TraceLayer};
use tracing::Level;
use std::net::SocketAddr;

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
        .merge(change_course_info_routes())
        .fallback(any(route_not_found))
        .with_state(state)
        .layer(
            // 中间件，用于Tracing日志
            TraceLayer::new_for_http()
                .make_span_with(trace::DefaultMakeSpan::new()
                    .level(Level::INFO))
                .on_response(trace::DefaultOnResponse::new()
                    .level(Level::INFO)),
        );
    
    let addr = SocketAddr::from(([127, 0, 0, 1], 8081));
    let listener = tokio::net::TcpListener::bind(&addr).await?;
    tracing::info!("listening on {}", addr);
    axum::serve(listener, app).await?;

    Ok(())
}

pub fn main() {
    tracing_subscriber::fmt()
    .with_target(false)
    .compact()
    .init();

    let result = start();

    if let Some(err) = result.err() {
        println!("Error: {err}");
    }
}
