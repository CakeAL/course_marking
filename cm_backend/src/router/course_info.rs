use axum::{
    Router,
    routing::get,
};
use crate::handler::course_info::*;
use crate::state::AppState;

pub fn get_course_info_routes() -> Router<AppState> {
    Router::new()
        .route("/api/course_info/getall", get(get_all_course_info))
        .route("/api/course_info/getone/:course_code", get(get_one_course_info))
}