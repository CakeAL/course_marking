use axum::{
    extract::{Path, State},
    http::StatusCode,
    Json,
};

use crate::{
    dbaccess::comments::{delete_comment, insert_comment_for_course, select_comments_for_course, select_comments_for_user},
    state::AppState,
};

pub async fn get_comments_for_course(
    state: State<AppState>,
    Path(course_id): Path<i32>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    let res = select_comments_for_course(&state.db_conn, course_id).await;
    match res {
        Ok(comments) => Ok(Json(serde_json::json!(comments))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn get_comments_for_user(
    state: State<AppState>,
    Path(user_id): Path<i32>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    let res = select_comments_for_user(&state.db_conn, user_id).await;
    match res {
        Ok(comments) => Ok(Json(serde_json::json!(comments))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn post_comment_for_course(
    state: State<AppState>,
    new_comment_json: serde_json::Value,
) -> StatusCode {
    let res = insert_comment_for_course(&state.db_conn, new_comment_json).await;
    match res {
        Ok(()) => StatusCode::NO_CONTENT,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

pub async fn user_delete_comment(
    state: State<AppState>,
    Path(comment_id): Path<i32>,
) -> StatusCode {
    let res = delete_comment(&state.db_conn, comment_id).await;
    match res {
        Ok(()) => StatusCode::NO_CONTENT,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

#[cfg(test)]
mod test {
    use crate::util::get_db_connection;
    use super::*;

    #[tokio::test]
    async fn test_get_comments_for_course() {
        let state = State::<AppState>(AppState { db_conn: get_db_connection().await.unwrap() });
        let res = get_comments_for_course(state, Path(3)).await;
        println!("{:?}", res);
    }

    #[tokio::test]
    async fn test_post_comment_for_course() {
        let state = State::<AppState>(AppState { db_conn: get_db_connection().await.unwrap() });
        let res = post_comment_for_course(
            state, serde_json::json!({
            "course_id": 3,
            "user_id": 1,
            "comment": "test_comment"
        })).await;
        assert_eq!(res, StatusCode::NO_CONTENT);
    }
}