<script setup>
import axios from "axios";
import codeStore from "./codeStore.js";

onBeforeMount(() => {
  // console.log(codeStore.courseCode);
  fetchCourseData();
  if_display.value = true;
});
const courseData = ref({});
const if_display = ref(false);
const fetchCourseData = async () => {
  try {
    const response = await axios.get(
      "/api/course_info/getone/" + codeStore.courseCode
    );
    courseData.value = response.data;
    // console.log(courseData.value);
  } catch (error) {
    console.error(error);
  }
};
</script>

<template>
  <el-card style="max-width: 600px" shadow="hover" class="content-component">
    <template #header>
      <div class="card-header">
        <span style="margin-right: 10px">{{ courseData.course_name }}</span>
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
</template>

<style scoped></style>
