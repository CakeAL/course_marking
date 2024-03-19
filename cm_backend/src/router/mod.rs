use axum::http::StatusCode;

pub mod course_info;
pub mod comments;
pub mod users;

pub async fn route_not_found() -> StatusCode {
    StatusCode::NOT_FOUND
}