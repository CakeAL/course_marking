<script setup>
import md5 from "js-md5";
import axios from "axios";
import codeStore from "./codeStore.js";

const userLogin = reactive({
  student_id: "",
  password: "",
  verify_code: "",
});
const submitUserLogin = reactive({
  student_id: "",
  password: "",
  verify_code: "",
});
const onSubmitUser = async () => {
  submitUserLogin.password = md5(userLogin.student_id + userLogin.password);
  submitUserLogin.verify_code = md5(userLogin.verify_code);
  submitUserLogin.student_id = userLogin.student_id;
  // console.log(submitUserLogin);
  try {
    const response = await axios.post("/api/users/login", submitUserLogin, {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });
    // console.log(response)
    getUserInfo(submitUserLogin.student_id);
    ElMessage({
      message: "登录成功",
      type: "success",
    });
  } catch (error) {
    //console.error(error);
    ElMessage.error(
      error + "悲报：服务器说它是个茶壶。检查一下用户名/密码/提问是否写错了。"
    );
  }
};

const userRegister = reactive({
  student_id: "",
  password: "",
  verify_code: "",
  username: "",
});
const submitRegister = reactive({
  student_id: "",
  password: "",
  verify_code: "",
  username: "",
});
const onSubmitUserReg = async () => {
  submitRegister.password = md5(
    userRegister.student_id + userRegister.password
  );
  submitRegister.verify_code = md5(userRegister.verify_code);
  submitRegister.student_id = userRegister.student_id;
  submitRegister.username = userRegister.username;
  // console.log(submitRegister);
  try {
    const response = await axios.post("/api/users/register", submitRegister, {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });
    console.log(response);
    ElMessage({
      message: response,
      // type: "success",
    });
  } catch (error) {
    //console.error(error);
    ElMessage.error(error + "🤔");
  }
};
const getUserInfo = async (student_id) => {
  try {
    const response = await axios.get("/api/users/getinfo/" + student_id);
    codeStore.userInfo = response.data;
    // console.log(codeStore.userInfo);
  } catch (error) {
    //console.error(error);
    ElMessage.error(error + "🤔");
  }
}
</script>

<template>
  <el-tabs type="border-card" tab-position="left">
    <el-tab-pane label="登录">
      <el-form :model="userLogin" label-width="auto" style="max-width: 600px">
        <el-form-item label="学号">
          <el-input v-model="userLogin.student_id" />
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="userLogin.password" />
        </el-form-item>
        <el-form-item
          label="校园网注销/登录页的ip是？(格式类似于 127.0.0.1 or 255.255.255.0)"
        >
          <el-input v-model="userLogin.verify_code" />
        </el-form-item>
        <el-button type="primary" @click="onSubmitUser">登录</el-button>
      </el-form>
    </el-tab-pane>
    <el-tab-pane label="注册">
      <el-form
        :model="userRegister"
        label-width="auto"
        style="max-width: 600px"
      >
        <el-form-item label="用户名">
          <el-input v-model="userRegister.username" />
        </el-form-item>
        <el-form-item label="学号">
          <el-input v-model="userRegister.student_id" />
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="userRegister.password" />
        </el-form-item>
        <el-form-item
          label="校园网注销/登录页的ip是？(格式类似于 127.0.0.1 or 255.255.255.0)"
        >
          <el-input v-model="userRegister.verify_code" />
        </el-form-item>
        <el-button type="primary" @click="onSubmitUserReg">注册</el-button>
      </el-form>
    </el-tab-pane>
  </el-tabs>
</template>

<style scoped></style>
