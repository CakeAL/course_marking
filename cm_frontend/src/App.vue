<script lang="ts" setup>
// import { ref, computed } from "vue";
// 图标
import { Menu as IconMenu, Expand, Fold } from "@element-plus/icons-vue";
// 子页面
import Home from "/src/Home.vue";
import About from "/src/About.vue";
import CoursePage from "/src/CoursePage.vue";
import UserLogin from "/src/UserLogin.vue";
import UserPage from "/src/UserPage.vue";
import NotFound from "/src/NotFound.vue";
// 路由
const routes = {
  "/": Home,
  "/about": About,
  "/coursepage": CoursePage,
  "/userlogin": UserLogin,
  "/userpage": UserPage,
};
const currentPath = ref(window.location.hash);
window.addEventListener("hashchange", () => {
  currentPath.value = window.location.hash;
});
const currentView = computed(() => {
  return routes[currentPath.value.slice(1) || "/"] || NotFound;
});
// el-menu 上面
const activeIndex = ref("0");
const handleSelect = (key: string, keyPath: string[]) => {
  console.log(key, keyPath);
};
// el-menu 侧面
const icon = ref("1");
const isCollapse = ref(true);
const changeIcon = () => {
  icon.value = icon.value === "1" ? "2" : "1";
  isCollapse.value = icon.value === "1" ? true : false;
};
</script>

<template>
  <!-- 用来复制的路由 -->
  <!-- 
  <a href="#/">Home</a><br />
  <a href="#/about">About</a><br />
  <a href="#/coursepage">Course Page</a><br />
  <a href="#/userlogin">User Login</a><br />
  <a href="#/userpage">User Page</a><br /> 
  -->
  <el-menu
    :default-active="activeIndex"
    class="el-menu"
    mode="horizontal"
    @select="handleSelect"
  >
    <el-menu-item index="0" @click="changeIcon" class="el-menu-icon">
      <transition name="fade">
        <div v-if="icon === '1'">
          <el-icon><Expand /></el-icon>
        </div>
        <div v-else>
          <el-icon><Fold /></el-icon>
        </div>
      </transition>
    </el-menu-item>
    <el-menu-item index="1">
      <a href="#/" class="menu-title">
        Public Course Marking —— USTB公选课打分系统
      </a>
    </el-menu-item>
  </el-menu>
  <div class="menu-component-container">
    <el-menu class="el-menu-vertical" :collapse="isCollapse">
      <el-menu-item index="1">
        <el-icon><IconMenu /></el-icon>
        <template #title><a href="#/">主页</a></template>
      </el-menu-item>
    </el-menu>

    <component :is="currentView" class="show-content" />
  </div>
</template>

<style scoped>
.menu-title {
  font-size: 1.3em;
  font-weight: bold;
  text-decoration: none;
}

.el-menu-vertical {
  /* position: fixed; */
  top: 0;
  left: 0;
  height: 100vh;
  flex: 0 0 auto;
}

.el-menu-vertical:not(.el-menu--collapse) {
  width: 200px;
  min-height: 100%;
}

.el-menu-icon {
  width: 63px;
}

.show-content {
  flex: 1;
  justify-content: center;
  align-items: center;
  display: flex;
}

.menu-component-container {
  display: flex;
  align-items: flex-start;
}
</style>
