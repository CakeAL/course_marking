use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize, Debug, Clone)]
pub struct CourseInfo {
    pub id: i32,
    pub course_code: String,
    pub course_name: String,
    pub teacher: Option<String>,
    pub credits: Option<i32>,
    pub course_type: Option<String>,
    pub marking: Option<f64>,
    pub is_attendance: Option<String>,
    pub homework: Option<String>,
    pub exam: Option<String>,
}