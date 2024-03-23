<script setup>
// import { ref, computed } from "vue";
// 图标
import { Menu as IconMenu, Expand, Fold, User, InfoFilled } from "@element-plus/icons-vue";
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

// el-menu 侧面
const icon = ref("1");
const isCollapse = ref(true);
const asideWidth = ref("64px");
const changeIcon = () => {
  icon.value = icon.value === "1" ? "2" : "1";
  isCollapse.value = icon.value === "1" ? true : false;
  if (icon.value === "1") {
    setTimeout(() => {
      asideWidth.value = "64px";
    }, 500);
  } else {
    asideWidth.value = "200px";
  }
};
// 检测cookie，随便伪造😅
const checkCookieExists = (cookieName) => {
  const cookies = document.cookie.split(";");

  for (let i = 0; i < cookies.length; i++) {
    const cookie = cookies[i].trim();
    if (cookie.startsWith(cookieName + "=")) {
      return true;
    }
  }

  return false;
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
  <div class="common-layout">
    <el-container>
      <el-header style="padding: 0">
        <el-menu
          :default-active="activeIndex"
          class="el-menu"
          mode="horizontal"
        >
          <el-menu-item index="0" @click="changeIcon" class="el-menu-icon">
            <div v-if="icon === '1'">
              <el-icon><Expand /></el-icon>
            </div>
            <div v-else>
              <el-icon><Fold /></el-icon>
            </div>
          </el-menu-item>
          <el-menu-item index="1">
            <a href="#/" class="menu-title">
              Public Course Marking —— USTB公选课打分系统
            </a>
          </el-menu-item>
        </el-menu>
      </el-header>
      <el-container>
        <el-aside :width="asideWidth">
          <el-menu class="el-menu-vertical" :collapse="isCollapse">
            <a href="#/">
              <el-menu-item index="1">
                <el-icon><IconMenu /></el-icon>
                <template #title>主页</template>
              </el-menu-item></a
            >
            <div v-if="checkCookieExists('StudentId')">
              <a href="#/userlogin">
                <el-menu-item index="2">
                  <el-icon><User /></el-icon>
                  <template #title>个人主页</template>
                </el-menu-item>
              </a>
            </div>
            <div v-else>
              <a href="#/userlogin">
                <el-menu-item index="2">
                  <el-icon><User /></el-icon>
                  <template #title>登录/注册</template>
                </el-menu-item>
              </a>
            </div>
            <a href="#/about">
                <el-menu-item index="2">
                  <el-icon><InfoFilled /></el-icon>
                  <template #title>关于</template>
                </el-menu-item>
              </a>
          </el-menu>
        </el-aside>
        <el-main>
          <component :is="currentView" />
        </el-main>
      </el-container>
    </el-container>
  </div>
  <el-backtop :right="100" :bottom="100" />
</template>

<style scoped>
.menu-title {
  font-size: 1.3em;
  font-weight: bold;
  text-decoration: none;
}

.el-menu-vertical {
  min-height: 100%;
}

.el-menu-vertical:not(.el-menu--collapse) {
  width: 200px;
}

.el-menu-icon {
  width: 63px;
}
</style>
