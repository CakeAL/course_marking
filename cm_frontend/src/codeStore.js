import { reactive } from "vue";

const codeStore = reactive({
  courseCode: "",
  userInfo: {
    created_at: "",
    id: 0,
    student_id: "",
    username: "",
  },
});

export default codeStore;
