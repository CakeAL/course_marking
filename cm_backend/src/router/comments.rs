use axum::{routing::{delete, get, post}, Router};

use crate::{handler::comments::*, state::AppState};

pub fn comments_routes() -> Router<AppState> {
    Router::new()
    .route(
        "/api/comments/getforcourse/:course_id",
        get(get_comments_for_course),
    )
    .route("/api/comments/getforuser/:user_id", get(get_comments_for_user))
    .route("/api/comments/postone", post(post_comment_for_course))
    .route("/api/comments/delone/:comment_id", delete(user_delete_comment))
}