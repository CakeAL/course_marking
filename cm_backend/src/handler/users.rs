use crate::{
    dbaccess::users::{
        insert_a_user, select_password_for_user, select_user_info, update_user_password,
    },
    state::AppState,
};
use axum::{
    extract::{Path, State},
    http::{HeaderMap, StatusCode},
    response::IntoResponse,
    Form, Json,
};
use serde_json::json;
use tower_cookies::Cookies;
use super::check_student_id_cookie;

#[derive(serde::Deserialize, Debug)]
pub struct LoginUserInfo {
    student_id: String,
    password: String,
    verify_code: String,
}

// 验证用户密码是否正确（登录）
pub async fn determine_password_for_user(
    state: State<AppState>,
    Form(login_user_info): Form<LoginUserInfo>,
) -> (StatusCode, impl IntoResponse) {
    let mut headers = HeaderMap::new();
    // 验证一下验证码，一个问题罢了，不对的话重定向到对应链接
    if login_user_info.verify_code != "95b996f410336697436622879d57d73f".to_string() {
        headers.insert(
            axum::http::header::LOCATION,
            "/login?msg=验证码错误".parse().unwrap(),
        );
        return (StatusCode::IM_A_TEAPOT, headers);
    }
    // 查询对应学号密码
    let res = select_password_for_user(&state.db_conn, &login_user_info.student_id).await;
    // println!("{}\n{:?}", login_user_info.student_id, res);
    match res {
        // 查询到了密码
        Ok(user_password) => {
            // 对比密码是否正确，如果不正确重定向到学号或密码错误
            if user_password != login_user_info.password {
                headers.insert(
                    axum::http::header::LOCATION,
                    "/login?msg=学号或密码错误".parse().unwrap(),
                );
                (StatusCode::IM_A_TEAPOT, headers)
            // 正确的话，设置cookie
            } else {
                // println!("{}\n{}", login_user_info.password, user_password);
                let cookie = format!("{}={}; Path=/api", "StudentId", login_user_info.student_id);
                headers.insert(
                    axum::http::header::SET_COOKIE,
                    cookie.as_str().parse().unwrap(),
                );
                // headers.insert(axum::http::header::LOCATION, "/".parse().unwrap());
                (StatusCode::OK, headers)
            }
        }
        // 查询出错，直接重定向到学号或者密码错误
        Err(_) => {
            headers.insert(
                axum::http::header::LOCATION,
                "/login?msg=学号或密码错误".parse().unwrap(),
            );
            (StatusCode::IM_A_TEAPOT, headers)
        }
    }
}

// 前端需要判断 重复密码 是否和 密码 相同。
#[derive(serde::Deserialize)]
pub struct RegisterUserInfo {
    username: String,
    student_id: String,
    password: String,
    verify_code: String,
}

pub async fn register_a_user(
    state: State<AppState>,
    Form(register_user_info): Form<RegisterUserInfo>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    // 验证一下验证码，一个问题罢了，不对的话重定向到对应链接
    if register_user_info.verify_code != "95b996f410336697436622879d57d73f".to_string() {
        return Ok(Json(serde_json::json!(r#"{"error":"验证码错误"}"#)));
    }
    let res = insert_a_user(
        &state.db_conn,
        register_user_info.username,
        register_user_info.student_id,
        register_user_info.password,
    )
    .await;
    match res {
        Ok(()) => Ok(Json(serde_json::json!(r#"{"success":"注册成功"}"#))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn get_user_info(
    state: State<AppState>,
    Path(student_id): Path<String>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    let res = select_user_info(&state.db_conn, student_id).await;
    match res {
        Ok(info) => Ok(Json(serde_json::json!(info))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

#[derive(serde::Deserialize)]
pub struct ChangeUserPassword {
    user_id: i32,
    student_id: String,
    password: String,
}

pub async fn change_user_password(
    state: State<AppState>,
    cookies: Cookies,
    Form(change_user_password): Form<ChangeUserPassword>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    // 检查用户权限
    if let Err(err) = check_student_id_cookie(&state, &cookies).await {
        return Err(err);
    }
    let old_password =
        match select_password_for_user(&state.db_conn, &change_user_password.student_id).await {
            Ok(pass) => pass,
            Err(_) => return Err(StatusCode::INTERNAL_SERVER_ERROR),
        };
    if old_password == change_user_password.password {
        Ok(Json(json!(r#"{"error":"新密码不能与原来的密码相同"}"#)))
    } else {
        let res = update_user_password(
            &state.db_conn,
            change_user_password.user_id,
            change_user_password.password,
        )
        .await;
        match res {
            Ok(()) => Ok(Json(json!(r#"{"success":"密码修改成功"}"#))),
            Err(_) => return Err(StatusCode::INTERNAL_SERVER_ERROR),
        }
    }
}

pub async fn user_logout() -> (StatusCode, HeaderMap) {
    let cookie = format!("{}=", "StudentId");
    let mut headers = HeaderMap::new();
    headers.insert(
        axum::http::header::SET_COOKIE,
        cookie.as_str().parse().unwrap(),
    );
    // headers.insert(axum::http::header::LOCATION, "/".parse().unwrap());
    (StatusCode::FOUND, headers)
}
