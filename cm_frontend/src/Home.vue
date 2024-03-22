<script setup>
import axios from "axios";

const coursesData = ref(null);

onMounted(() => {
  fetchCoursesData();
});

const fetchCoursesData = async () => {
  try {
    const response = await axios.get("/api/course_info/getall");
    coursesData.value = response.data;
    // console.log(coursesData.value)
  } catch (error) {
    console.error(error);
  }
};

const getCoursePageLink = (courseCode) => {
  return `#/coursepage/${courseCode}`;
};
</script>

<template>
  <div v-for="course in coursesData" class="show-content">
    <a :href="getCoursePageLink(course.course_code)">
      <el-card
        style="max-width: 600px"
        shadow="hover"
        class="content-component"
      >
        <template #header>
          <div class="card-header">
            <span style="margin-right: 10px">{{ course.course_name }}</span>
            <el-tag type="primary" style="margin-right: 10px">{{
              course.course_type
            }}</el-tag>
            <el-tag type="success" style="margin-right: 10px"
              >学分：{{ course.credits }}</el-tag
            >
          </div>
        </template>
        <p>课程编号：{{ course.course_code }}</p>
        <p>教师姓名：{{ course.teacher }}</p>
        <p>平时作业：{{ course.homework }}</p>
        <p>是否点名：{{ course.is_attendance }}</p>
        <p>考核形式：{{ course.exam }}</p>
      </el-card>
    </a>
  </div>
</template>

<style scoped>
.show-content {
  text-align: center;
  display: flex;
  justify-content: center;
  padding-bottom: 10px;
}

.content-component {
  width: 600px;
  text-align: left;
}

.card-header {
  text-align: center;
}
</style>
