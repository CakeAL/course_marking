<script setup>

</script>

<template>
  <h1>About</h1>
  <el-card style="max-width: 1080px">
    <template #header>
      <div class="card-header">
        <span>简介</span>
      </div>
    </template>
    <div class="flex flex-wrap gap-4"> 
         <el-card style="width: 1080px" shadow="hover" >
          <p class="text">这是一个前后端分离(人不分离)的Web APP。 </p> 
          <p class="text">前端使用Vue + Element-Plus构建，后端使用Rust + Axum + SeaORM，数据库使用Postgres。  </p>
          <p class="text">用来给学校的公选课打分和评价。</p></el-card>
  </div>
    <template #footer></template>
  </el-card>
  <el-card style="max-width: 1080px">
    <template #header>
      <div class="card-header">
        <span>主要功能</span>
      </div>
    </template>
    <div class="flex flex-wrap gap-4"> 
         <el-card style="width: 1080px" shadow="hover">
          <el-table :data="tableData" stripe style="width: 100%">
    <el-table-column prop="date" label="功能" width="180" />
    <el-table-column prop="name" label="描述" width="300" />
   
  </el-table>  
        </el-card>
  </div>
    <template #footer></template>
  </el-card>
  <el-card style="max-width: 1080px">
    <template #header>
      <div class="card-header">
        <span>TODO</span>
      </div>
    </template>
    <div class="flex flex-wrap gap-4"> 
         <el-card style="width: 1080px" shadow="hover">
          <p>1. 前端页面，缺了很多功能.</p>
<p>2. 课程评分暂未实装 </p>
<p>3. 改进Cookie </p>
<p>4. 评论部分可以每次读取10条，无限滚动</p>
<p>5. 评论的时间是UTC，不是UTC+8🤔。</p></el-card>
  </div>
    <template #footer></template>
  </el-card>
  <el-card style="max-width: 1080px">
    <template #header>
      <div class="card-header">
        <span>运行</span>
      </div>
    </template>
    <div class="flex flex-wrap gap-4"> 
         <el-card style="width: 1080px" shadow="hover">
          <p>本项目使用node，npm，cargo，请提前装好。</p>
          <p>1.cm_backend 生成entity，注意设置.env</p>
          <p>
            <div class="flex gap-2">

    <el-tag type="info">cargo install sea-orm-cli
sea-orm-cli generate entity -u postgres://cakeal:20030214@127.0.0.1:5432/course_marking -o src/entity --with-serde both</el-tag>

  </div>
          </p>
          <p>2.PostgreSQL脚本</p>
          <p>在/sql文件夹下</p>
          <p>3.后端</p>
          <p><div class="flex gap-2">

<el-tag type="info">cargo run</el-tag>

</div></p>
          <p>4.前端</p>
          <p><div class="flex gap-2">

<el-tag type="info">cd cm_frontend</el-tag>

</div></p>
<p><div class="flex gap-2">

<el-tag type="info">npm install</el-tag>

</div></p>
<p><div class="flex gap-2">

<el-tag type="info">npm run dev</el-tag>

</div></p>
         </el-card>
  </div>
    <template #footer></template>
  </el-card>
</template>

<script lang="ts" setup>
const tableData = [
  {
    date: '用户相关',
    name: '登录，注册，获取个人信息 ',
  },
  {
    date: '评论相关',
    name: ' 获取该课程的评论，获取该用户的评论，发布一条评论，用户删除一条评论，给评论投赞成/反对票 ',
  },
  {
    date: '课程相关 ',
    name: '获取全部课程信息，获取当前课程信息，更改当前课程信息',
  },
  {
    date: ' ',
    name: ' ',
  },
]
</script>

<style scoped>
.text{
  text-align: center;
}
</style>
