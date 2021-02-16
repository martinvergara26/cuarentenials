import { createRouter, createWebHistory } from "vue-router";
import Home from '@/views/Home.vue'
import SignUp from '@/views/SignUp.vue'
import SignIn from '@/views/SignIn.vue'
import PhaseCreate from '@/views/PhaseCreate.vue'
import BirthList from '@/views/BirthList.vue'
import BirthDetails from '@/views/BirthDetails.vue'
import BirthCreate from '@/views/BirthCreate.vue'
import MyBirthDetails from '@/views/MyBirthDetails.vue'
import MyBirthList from '@/views/MyBirthList.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/create_phase',
    name: 'create_phase',
    component: PhaseCreate,
    meta: { requiresAuth: true }
  },
  {
    path: '/births',
    name: 'births',
    component: BirthList,
    meta: { requiresAuth: true }
  },
  {
    path: '/birth_create',
    name: 'birth_create',
    component: BirthCreate,
    meta: { requiresAuth: true }
  },
  {
    path: '/my_births',
    name: 'my_births',
    component: MyBirthList,
    meta: { requiresAuth: true }
  },
  {
    path: '/my_births/:id',
    name: 'my_birth_details',
    props: true,
    component: MyBirthDetails,
    meta: { requiresAuth: true }
  },
  {
    path: '/births/:id',
    name: 'birth_details',
    props: true,
    component: BirthDetails,
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
