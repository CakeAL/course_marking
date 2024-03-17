use anyhow::{Ok, Result};
use sea_orm::{ActiveModelTrait, ColumnTrait, DatabaseConnection, EntityTrait, QueryFilter, QueryOrder};
use serde_json::json;

use crate::entity::comments;
use crate::entity::prelude::Comments;

// 根据当前页面课程id，选择对应的所有评论并返回
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

// 根据当前用户，选择对应的所有评论并返回
pub async fn select_comments_for_user(
    db: &DatabaseConnection,
    user_id: i32,
) -> Result<Vec<comments::Model>> {
    let rows = Comments::find()
    .filter(comments::Column::UserId.eq(user_id))
    .order_by_desc(comments::Column::CreatedAt)
    .all(db)
    .await?;
Ok(rows)
}

// 插入一条评论
pub async fn insert_comment_for_course(
    db: &DatabaseConnection,
    new_comment_json: serde_json::Value,
) -> Result<()> {
    let new_comment = comments::ActiveModel::from_json(json!(new_comment_json))?;
    new_comment.insert(db).await?;
    Ok(())
}

// 删除一条评论
pub async fn delete_comment(
    db: &DatabaseConnection,
    id: i32,
) -> Result<()> {
    let _ = Comments::delete_by_id(id).exec(db).await?;
    Ok(())
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

    #[tokio::test]
    async fn test_select_comments_for_user() {
        let db = get_db_connection().await.unwrap();
        let info = select_comments_for_user(&db, 1).await.unwrap();
        println!("{:?}", info);
    }

    #[tokio::test]
    async fn test_insert_comment_for_course() {
        let db = get_db_connection().await.unwrap();
        let res = insert_comment_for_course(&db, json!({
            "course_id": 3,
            "user_id": 1,
            "comment": "test_comment"
        })).await;
        println!("{:?}", res);
    }

    #[tokio::test]
    async fn test_delete_comment() {
        let db = get_db_connection().await.unwrap();
        let res = delete_comment(&db, 24).await;
        println!("{:?}", res);
    }
}