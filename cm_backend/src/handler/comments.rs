use axum::{
    extract::{Path, State},
    http::StatusCode,
    Json,
};
use tower_cookies::Cookies;

use super::check_student_id_cookie;
use crate::{dbaccess::comments::*, state::AppState};

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
    cookies: Cookies,
    Path(user_id): Path<i32>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    // 检查用户权限
    if let Err(err) = check_student_id_cookie(&state, &cookies).await {
        return Err(err);
    }
    let res = select_comments_for_user(&state.db_conn, user_id).await;
    match res {
        Ok(comments) => Ok(Json(serde_json::json!(comments))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn post_comment_for_course(
    state: State<AppState>,
    cookies: Cookies,
    new_comment_raw: String,
) -> StatusCode {
    // 检查用户权限
    if let Err(err) = check_student_id_cookie(&state, &cookies).await {
        return err;
    }
    // println!("{:?}", new_comment_json);
    let new_comment_json = match serde_json::from_str(&new_comment_raw) {
        Ok(inner) => inner,
        Err(_) => return StatusCode::BAD_REQUEST,
    };
    let res = insert_comment_for_course(&state.db_conn, new_comment_json).await;
    match res {
        Ok(()) => StatusCode::CREATED,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

pub async fn user_delete_comment(
    state: State<AppState>,
    cookies: Cookies,
    Path(comment_id): Path<i32>,
) -> StatusCode {
    // 检查用户权限
    if let Err(err) = check_student_id_cookie(&state, &cookies).await {
        return err;
    }
    let res = delete_comment(&state.db_conn, comment_id).await;
    match res {
        Ok(()) => StatusCode::RESET_CONTENT,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

pub async fn up_votes_addone(
    state: State<AppState>,
    cookies: Cookies,
    Path(comment_id): Path<i32>,
) -> StatusCode {
    // 检查用户权限
    if let Err(err) = check_student_id_cookie(&state, &cookies).await {
        return err;
    }
    let res = update_up_votes(&state.db_conn, comment_id).await;
    match res {
        Ok(()) => StatusCode::NO_CONTENT,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

pub async fn down_votes_addone(
    state: State<AppState>,
    cookies: Cookies,
    Path(comment_id): Path<i32>,
) -> StatusCode {
    // 检查用户权限
    if let Err(err) = check_student_id_cookie(&state, &cookies).await {
        return err;
    }
    let res = update_down_votes(&state.db_conn, comment_id).await;
    match res {
        Ok(()) => StatusCode::NO_CONTENT,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

#[cfg(test)]
mod test {
    use super::*;
    use crate::util::get_db_connection;

    #[tokio::test]
    async fn test_get_comments_for_course() {
        let state = State::<AppState>(AppState {
            db_conn: get_db_connection().await.unwrap(),
        });
        let res = get_comments_for_course(state, Path(3)).await;
        println!("{:?}", res);
    }

    // #[tokio::test]
    // async fn test_post_comment_for_course() {
    //     let state = State::<AppState>(AppState {
    //         db_conn: get_db_connection().await.unwrap(),
    //     });
    //     let body = String::from(
    //         r#"{
    //         "course_id": 3,
    //         "user_id": 1,
    //         "comment": "test_comment",
    //         "username": "test_user"
    //     }"#,
    //     );
    //     let res = post_comment_for_course(state, body).await;
    //     assert_eq!(res, StatusCode::CREATED);
    // }
}
