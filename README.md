# Course marking 公选课学生打分系统  
## 简介  
这是一个前后端分离(人不分离)的Web APP。  
前端使用Vue构建，后端使用Rust + Axum + SeaORM，数据库使用Postgres。  
用来给学校的公选课打分和评价。  
## 主要功能  
| 功能      | 描述 |
| ----------- | ----------- |
| 用户相关      | 登录，注册，获取个人信息，更改密码，退出登录       |
| 评论相关   | 获取该课程的评论，获取该用户的评论，发布一条评论，用户删除一条评论，给评论投赞成/反对票 |
| 课程相关 | 获取全部课程信息，获取当前课程信息，更改当前课程信息 |
### TODO  
1. 前端页面  
2. 课程评分暂未实装  
3. 改进Cookie  
## 运行  
本项目使用node，npm，cargo，请提前装好。  
* cm_backend 生成entity，注意设置.env  
```bash
cargo install sea-orm-cli
sea-orm-cli generate entity -u postgres://cakeal:20030214@127.0.0.1:5432/course_marking -o src/entity --with-serde both
```
* PostgreSQL脚本  
在`/sql`文件夹下  
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