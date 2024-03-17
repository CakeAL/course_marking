use anyhow::{Ok, Result};
use sea_orm::{ColumnTrait, DatabaseConnection, EntityTrait, QueryFilter, QueryOrder};

use crate::entity::comments;
use crate::entity::prelude::Comments;

pub async fn select_comments_for_course(
    db: &DatabaseConnection,
    course_id: i32,
) -> Result<Vec<comments::Model>> {
    let rows = Comments::find()
        .filter(comments::Column::CourseId.eq(course_id))
        .order_by_desc(comments::Column::CreatedAt)
        .all(db)
        .await?;
    Ok(rows)
}


#[cfg(test)]
mod test {
    use crate::util::get_db_connection;

    use super::*;

    #[tokio::test]
    async fn test_select_comments_for_course() {
        let db = get_db_connection().await.unwrap();
        let info = select_comments_for_course(&db, 3).await.unwrap();
        println!("{:?}", info);
    }
}