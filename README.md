# Course marking 公选课学生打分系统  
## 简介  
这是一个前后端分离(人不分离)的Web APP。  
前端使用Vue构建，后端使用Rust + Axum + SeaORM，数据库使用Postgres。  
用来给学校的公选课打分和评价。  
## 主要功能  
| 功能      | 描述 |
| ----------- | ----------- |
| 未完成      | 未完成       |
| 未完成   | 未完成        |
### TODO  

## 运行  
本项目使用node，npm，cargo，请提前装好。  
* cm_backend 生成entity，注意设置.env
```bash
cargo install sea-orm-cli
sea-orm-cli generate entity -u postgres://cakeal:20030214@127.0.0.1:5432/course_marking -o src/entity --with-serde both
```
* 后端  
```bash
cargo run
```
* 前端  
```bash
cd cm_frontend
npm install
npm run dev
```

## 负责人

## License