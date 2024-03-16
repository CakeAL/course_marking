use sea_orm::DatabaseConnection;

// APP共享状态
#[derive(Clone)]
pub struct AppState {
    pub db_conn: DatabaseConnection,
}