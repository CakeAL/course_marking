<script setup>
import axios from "axios";
import codeStore from "./codeStore.js";
import { ArrowUp, ArrowDown } from "@element-plus/icons-vue";

onBeforeMount(() => {
  // console.log(codeStore.courseCode);
  fetchCourseData();
});
const courseData = ref({});
const fetchCourseData = async () => {
  try {
    const response = await axios.get(
      "/api/course_info/getone/" + codeStore.courseCode
    );
    courseData.value = response.data;
    fetchCommentsData();
    // console.log(courseData.value.id);
  } catch (error) {
    console.error(error);
  }
};
const commentsData = ref({});
const fetchCommentsData = async () => {
  try {
    const response = await axios.get(
      "/api/comments/getforcourse/" + courseData.value.id
    );
    commentsData.value = response.data;
    // console.log(commentsData.value);
  } catch (error) {
    console.error(error);
  }
};
const changeUpVotes = async (comment_id) => {
  try {
    const response = await axios.put("/api/comments/upvote/" + comment_id);
    ElMessage({
      message: "添加赞同成功！点一次就行了。",
      type: "success",
    });
  } catch (error) {
    //console.error(error);
    ElMessage.error(error + "可能是因为没登录的原因吧");
  }
};
const changeDownVotes = async (comment_id) => {
  try {
    const response = await axios.put("/api/comments/upvote/" + comment_id);
    ElMessage({
      message: "添加反对成功！点一次就行了。",
      type: "success",
    });
  } catch (error) {
    //console.error(error);
    ElMessage.error(error + "可能是因为没登录的原因吧");
  }
};
</script>

<template>
  <div class="common-layout">
    <el-container class="container">
      <el-aside width="650px">
        <el-card
          style="max-width: 600px; margin-bottom: 20px"
          shadow="hover"
          class="content-component"
        >
          <template #header>
            <div class="card-header">
              <span style="margin-right: 10px">{{
                courseData.course_name
              }}</span>
              <el-tag type="primary" style="margin-right: 10px">{{
                courseData.course_type
              }}</el-tag>
              <el-tag type="success" style="margin-right: 10px"
                >学分：{{ courseData.credits }}</el-tag
              >
            </div>
          </template>
          <p>课程编号：{{ courseData.course_code }}</p>
          <p>教师姓名：{{ courseData.teacher }}</p>
          <p>平时作业：{{ courseData.homework }}</p>
          <p>是否点名：{{ courseData.is_attendance }}</p>
          <p>考核形式：{{ courseData.exam }}</p>
        </el-card>
        <el-timeline style="max-width: 600px; padding: 0">
          <div v-for="comment in commentsData">
            <el-timeline-item :timestamp="comment.created_at" placement="top">
              <el-card>
                <h4>
                  {{ comment.username }}
                  <span @click="changeUpVotes(comment.id)"
                    ><el-icon><ArrowUp /></el-icon>赞同:{{
                      comment.up_votes
                    }}</span
                  >
                  <span @click="changeDownVotes(comment.id)"
                    ><el-icon><ArrowDown /></el-icon>反对:{{
                      comment.down_votes
                    }}</span
                  >
                </h4>
                <p>{{ comment.comment }}</p>
              </el-card>
            </el-timeline-item>
          </div>
        </el-timeline>
      </el-aside>
      <el-main>Main</el-main>
    </el-container>
  </div>
</template>

<style scoped></style>
