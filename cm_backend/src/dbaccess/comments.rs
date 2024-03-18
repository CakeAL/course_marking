use crate::entity::comments;
use crate::entity::prelude::Comments;
use anyhow::{anyhow, Ok, Result};
use sea_orm::{
    ActiveModelTrait, ColumnTrait, DatabaseConnection, EntityTrait, QueryFilter, QueryOrder, Set,
};

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
    let new_comment = comments::ActiveModel::from_json(new_comment_json)?;
    new_comment.insert(db).await?;
    Ok(())
}

// 删除一条评论
pub async fn delete_comment(db: &DatabaseConnection, id: i32) -> Result<()> {
    let _ = Comments::delete_by_id(id).exec(db).await?;
    Ok(())
}

// up_votes
pub async fn update_up_votes(db: &DatabaseConnection, id: i32) -> Result<()> {
    let comment: Option<comments::Model> = Comments::find_by_id(id).one(db).await?;
    let up_votes: Option<i32> = if let Some(v) = &comment {
        (*v).up_votes
    }
    else {
        return Err(anyhow::anyhow!("no comment found"));
    };
    let mut new_comment: comments::ActiveModel = comment.unwrap().into();
    new_comment.up_votes = Set(if let Some(v) = up_votes {
        Some(v + 1)
    } else {
        Some(1) //这里应该永远不会执行到
    });
    new_comment.update(db).await?;
    Ok(())
}

// down_votes
pub async fn update_down_votes(db: &DatabaseConnection, id: i32) -> Result<()> {
    let comment = Comments::find_by_id(id).one(db).await?;
    let down_votes: Option<i32> = if let Some(v) = &comment {
        // println!("{:?}", (*v).down_votes);
        (*v).down_votes
    }
    else {
        return Err(anyhow::anyhow!("no comment found"));
    };
    let mut new_comment: comments::ActiveModel = comment.unwrap().into();
    new_comment.down_votes = Set(if let Some(v) = down_votes {
        Some(v + 1)
    } else {
        Some(1) //这里应该永远不会执行到
    });
    new_comment.update(db).await?;
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
        let res = insert_comment_for_course(
            &db,
            serde_json::json!({
                "course_id": 3,
                "user_id": 1,
                "comment": "test_comment",
                "username": "test_user",
            }),
        )
        .await;
        println!("{:?}", res);
    }

    #[tokio::test]
    async fn test_delete_comment() {
        let db = get_db_connection().await.unwrap();
        let res = delete_comment(&db, 24).await;
        println!("{:?}", res);
    }

    #[tokio::test]
    async fn test_update_down_votes() {
        let db = get_db_connection().await.unwrap();
        let res = update_down_votes(&db, 1);
        assert_eq!(res.await.unwrap(), ());
    }
}
