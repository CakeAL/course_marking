use std::env;

use dotenv::dotenv;
use sea_orm::{Database, DatabaseConnection};
use anyhow::{Context, Result};

pub async fn get_db_connection() -> Result<DatabaseConnection> {
    dotenv().ok();
    let database_url = env::var("DATABASE_URL")
        .with_context(|| "DATABASE_URL is not set in .env file")?;
    let db: DatabaseConnection = Database::connect(&database_url)
        .await
        .with_context(|| format!("Database connection failed, the DATABASE_URL is {}", database_url))?;

    Ok(db)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_get_db_connection() {
        let db = get_db_connection().await.unwrap();
        assert!(db.ping().await.is_ok());
        let _ = db.close().await;
    }
}
