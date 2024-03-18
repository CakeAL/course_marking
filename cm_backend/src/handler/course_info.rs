use axum::{
    extract::{Path, State},
    http::StatusCode,
    Form, Json,
};
use serde::Deserialize;

use crate::{
    dbaccess::course_info::*,
    state::AppState,
};

pub async fn get_one_course_info(
    state: State<AppState>,
    Path(course_code): Path<String>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    let res = select_one_course_info(&state.db_conn, course_code).await;
    match res {
        Ok(course_info) => Ok(Json(serde_json::json!(course_info))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

pub async fn get_all_course_info(state: State<AppState>) -> Result<Json<serde_json::Value>, StatusCode> {
    let res = select_all_course_info(&state.db_conn).await;
    match res {
        Ok(course_infos) => Ok(Json(serde_json::json!(course_infos))),
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
    }
}

#[derive(Deserialize)]
pub struct NewCourseInfo {
    id: i32,
    teacher: Option<String>,
    is_attendance: Option<String>,
    homework: Option<String>,
    exam: Option<String>,
}

pub async fn change_one_course_info(
    state: State<AppState>,
    Form(new_course_info): Form<NewCourseInfo>,
) -> StatusCode {
    let res = update_one_course_info(
        &state.db_conn,
        new_course_info.id,
        new_course_info.teacher,
        new_course_info.is_attendance,
        new_course_info.homework,
        new_course_info.exam,
    )
    .await;
    match res {
        Ok(()) => StatusCode::RESET_CONTENT,
        Err(_) => StatusCode::INTERNAL_SERVER_ERROR,
    }
}

#[cfg(test)]
mod test {
    use super::*;
    use crate::util::get_db_connection;

    #[tokio::test]
    async fn test_get_one_course_info() {
        let db_conn = get_db_connection().await.unwrap();
        let state = State::<AppState>(AppState { db_conn });
        // let info = get_one_course_info(state, Path("1029007".into())).await;
        let info = get_one_course_info(state, Path("🤔".into())).await;
        // println!("{:?}", info);
        assert_eq!(Some(StatusCode::INTERNAL_SERVER_ERROR), info.err());
    }
}
