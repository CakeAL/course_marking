use axum::{routing::{delete, get, post, put}, Router};

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
    .route("/api/comments/upvote/:comment_id", put(up_votes_addone))
    .route("/api/comments/downvote/:comment_id", put(down_votes_addone))
}