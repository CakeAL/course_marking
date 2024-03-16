use axum::{
    extract::{Path, State},
    response::Response,
    Json,
};

use crate::{model::course_info::CourseInfo, state::AppState};

pub async fn get_all_course_info(
    state: State<AppState>
) -> Json<Vec<CourseInfo>> {
    todo!()
}

pub async fn get_one_course_info(
    state: State<AppState>, 
    Path(course_code): Path<i32>
) -> Json<CourseInfo>{
    todo!()
}
