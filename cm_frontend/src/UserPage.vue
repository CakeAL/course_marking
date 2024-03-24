<script setup>
import codeStore from "./codeStore.js";
import axios from "axios";

onMounted(() => {
  fetchUserComments()
})
const comments = ref({});
const fetchUserComments = async () => {
  try {
    const response = await axios.get("/api/comments/getforuser/" + codeStore.userInfo.id);
    comments.value = response.data;
  } catch (error) {
    console.error(error);
  }
};

</script>

<template>
  <el-descriptions
    title="个人信息"
    :column="2"
    :size="large"
    border
    style="max-width: 1000px; margin-bottom: 20px;"
  >
    <el-descriptions-item>
      <template #label> id </template>
      {{ codeStore.userInfo.id }}
    </el-descriptions-item>
    <el-descriptions-item>
      <template #label> 学号 </template>
      {{ codeStore.userInfo.student_id }}
    </el-descriptions-item>
    <el-descriptions-item>
      <template #label> 用户名 </template>
      {{ codeStore.userInfo.username }}
    </el-descriptions-item>
    <el-descriptions-item>
      <template #label> 创建时间（UTC） </template>
      {{ codeStore.userInfo.created_at }}
    </el-descriptions-item>
  </el-descriptions>
  <!-- <el-button type="primary" @click="logout">退出登录</el-button> -->

  <el-timeline style="max-width: 600px; padding: 0">
          <div v-for="comment in comments">
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
</template>

<style scoped></style>
