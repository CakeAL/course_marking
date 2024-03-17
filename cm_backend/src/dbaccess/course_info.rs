use crate::entity::course_info::{self, Entity as CourseInfo, Column};
use anyhow::{anyhow, Ok, Result};
use sea_orm::{ColumnTrait, DatabaseConnection, EntityTrait, QueryFilter};

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
}
