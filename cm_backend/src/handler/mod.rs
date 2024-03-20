use crate::dbaccess::users::select_password_for_user;
use crate::state::AppState;
use axum::extract::State;
use axum::http::StatusCode;
use tower_cookies::Cookies;

pub mod comments;
pub mod course_info;
pub mod users;

// 该函数用来检查cookie是否设置正确，如果错误返回401
pub async fn check_student_id_cookie(
    state: &State<AppState>,
    cookies: &Cookies,
) -> Result<(), StatusCode> {
    let student_id: Option<String> = cookies
        .get("StudentId")
        .and_then(|c| c.value().parse().ok());
    if let Some(sid) = student_id {
        // 这里直接根据查询student_id的密码，如果有密码说明数据库存在此账户
        let res = select_password_for_user(&state.db_conn, &sid).await;
        match res {
            Err(_) => Err(StatusCode::UNAUTHORIZED),
            _ => Ok(()),
        }
    } else {
        Err(StatusCode::UNAUTHORIZED)
    }
}
