use axum::{
    routing::{get, post},
    Router,
};
use crate::handler::users::*;
use crate::state::AppState;

pub fn users_routes() -> Router<AppState> {
    Router::new()
    .route("/api/users/login", post(determine_password_for_user))
    .route("/api/users/register", post(register_a_user))
    .route("/api/users/getinfo/:username", get(get_user_info))
    .route("/api/users/changepassword", post(change_user_password))
}