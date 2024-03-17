use axum::{
    extract::{Path, State},
    http::StatusCode,
    Json,
};

use crate::{dbaccess::course_info::select_one_course_info, state::AppState};

pub async fn get_all_course_info(state: State<AppState>) -> Json<serde_json::Value> {
    todo!()
}

pub async fn get_one_course_info(
    state: State<AppState>,
    Path(course_code): Path<String>,
) -> Result<Json<serde_json::Value>, StatusCode> {
    let res = select_one_course_info(&state.db_conn, course_code).await;
    match res {
        Ok(course_info) => {
            Ok(Json(serde_json::json!(course_info)))
        }
        Err(_) => Err(StatusCode::INTERNAL_SERVER_ERROR),
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
        let info = get_one_course_info(state, Path("1029007".into())).await;
        println!("{:?}", info);
    }
}
