use crate::handler::course_info::*;
use crate::state::AppState;
use axum::{
    routing::{get, post},
    Router,
};


pub fn course_info_routes() -> Router<AppState> {
    Router::new()
        .route("/api/course_info/getall", get(get_all_course_info))
        .route(
            "/api/course_info/getone/:course_code",
            get(get_one_course_info),
        )
        .route("/api/course_info/changeone", post(change_one_course_info))
}
