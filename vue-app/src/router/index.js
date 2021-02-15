import { createRouter, createWebHistory } from "vue-router";
import Home from '@/views/Home.vue'
import SignUp from '@/views/SignUp.vue'
import SignIn from '@/views/SignIn.vue'
import ChildList from '@/views/ChildList.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/childs',
    name: 'childs',
    component: ChildList,
    meta: { requiresAuth: true }
  },
  {
    path: '/sign_up',
    name: 'sign_up',
    component: SignUp
  },
  {
    path: '/sign_in',
    name: 'sign_in',
    component: SignIn
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

router.beforeEach((to, from, next) => {
  const loggedIn = localStorage.getItem('user')

  if (to.matched.some(record => record.meta.requiresAuth) && !loggedIn) {
    next('/')
  }
  next()
})


export default router;
