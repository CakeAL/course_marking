use crate::entity::{prelude::Users, users};
use anyhow::{Ok, Result};
use sea_orm::{
    ActiveModelTrait, ColumnTrait, DatabaseConnection, EntityTrait, Iterable, QueryFilter,
    QuerySelect, Set,
};

// 这里查询到的密码是md5加密的，前端应该这样加密"学号+密码"，合并后再md5
// 根据学号查询用户信息，然后返回密码
pub async fn select_password_for_user(
    db: &DatabaseConnection,
    student_id: &String,
) -> Result<String> {
    let row: Option<users::Model> = Users::find()
        .filter(users::Column::StudentId.eq(student_id))
        // .select_only()
        // .column(users::Column::Password)
        .one(db)
        .await?;
    match row {
        Some(user) => Ok(user.password.unwrap()),
        None => Err(anyhow::anyhow!("password is not found")),
    }
}

// // 根据username查询用户信息，然后返回密码
// pub async fn select_password_for_username(
//     db: &DatabaseConnection,
//     username: String,
// ) -> Result<String> {
//     let row = Users::find()
//         .filter(users::Column::Username.eq(&username))
//         .select_only()
//         .column(users::Column::Password)
//         .one(db)
//         .await?;
//     match row {
//         Some(user) => Ok(user.password.unwrap()),
//         None => Err(anyhow::anyhow!("password is not found")),
//     }
// }

// 注册用户
pub async fn insert_a_user(
    db: &DatabaseConnection,
    username: String,
    student_id: String,
    password: String,
) -> Result<()> {
    let new_user = users::ActiveModel {
        username: Set(username),
        student_id: Set(student_id),
        password: Set(Some(password)),
        ..Default::default()
    };
    new_user.insert(db).await?;
    Ok(())
}

// 返回当前用户所有信息
pub async fn select_user_info(db: &DatabaseConnection, student_id: String) -> Result<users::Model> {
    let row = Users::find()
        .filter(users::Column::StudentId.eq(&student_id))
        .select_only()
        .columns(users::Column::iter().filter(|col| match col {
            users::Column::Password => false,
            _ => true,
        }))
        .one(db)
        .await?;
    match row {
        Some(user) => Ok(user),
        None => Err(anyhow::anyhow!("user is not found")),
    }
}

// 更改密码
pub async fn update_user_password(
    db: &DatabaseConnection,
    user_id: i32,
    password: String,
) -> Result<()> {
    let new_user = Users::find_by_id(user_id).one(db).await?;
    let mut new_user: users::ActiveModel = new_user.unwrap().into();
    new_user.password = Set(Some(password));
    new_user.update(db).await?;
    Ok(())
}
