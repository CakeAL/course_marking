use crate::entity::course_info::{self, Column};
use crate::entity::prelude::CourseInfo;
use anyhow::{anyhow, Ok, Result};
use sea_orm::{ActiveModelTrait, ColumnTrait, DatabaseConnection, EntityTrait, QueryFilter, Set};

pub async fn select_one_course_info(
    db: &DatabaseConnection,
    course_code: String,
) -> Result<course_info::Model> {
    let row = CourseInfo::find()
        .filter(Column::CourseCode.contains(course_code))
        .one(db)
        .await?;
    if let Some(course_info) = row {
        Ok(course_info)
    } else {
        Err(anyhow!("course_info is not found"))
    }
}

pub async fn select_all_course_info(db: &DatabaseConnection) -> Result<Vec<course_info::Model>> {
    let rows = CourseInfo::find().all(db).await?;
    Ok(rows)
}

pub async fn update_one_course_info(
    db: &DatabaseConnection,
    id: i32,
    teacher: Option<String>,
    is_attendance: Option<String>,
    homework: Option<String>,
    exam: Option<String>,
) -> Result<()> {
    let course_info = CourseInfo::find_by_id(id).one(db).await?;
    // Into ActiveModel
    let mut course_info: course_info::ActiveModel = course_info.unwrap().into();
    // Update attributes
    course_info.teacher = Set(teacher);
    course_info.is_attendance = Set(is_attendance);
    course_info.homework = Set(homework);
    course_info.exam = Set(exam);
    // SQL
    course_info.update(db).await?;
    Ok(())
}

#[cfg(test)]
mod test {
    use crate::util::get_db_connection;

    use super::*;

    #[tokio::test]
    async fn test_select_one_course_info() {
        let db = get_db_connection().await.unwrap();
        let info = select_one_course_info(&db, "1019003".into()).await.unwrap();
        println!("{:?}", info);
    }

    #[tokio::test]
    async fn test_select_all_course_info() {
        let db = get_db_connection().await.unwrap();
        let info = select_all_course_info(&db).await.unwrap();
        println!("{:?}", info);
    }

    #[tokio::test]
    async fn test_update_one_course_info() {
        let db = get_db_connection().await.unwrap();
        // let info = update_one_course_info(
        //     &db,
        //     2,
        //     Some("TEACHER".into()),
        //     Some("ATTENDANCE".into()),
        //     Some("HOMEWORK".into()),
        //     Some("EXAM".into()),
        // ).await.unwrap();
        let info = update_one_course_info(&db, 2, None, None, None, None)
            .await
            .unwrap();
        assert_eq!(info, ());
    }
}
