<script setup>
import Numbers from './Numbers.vue'
</script>

<template>
    <div class="trending-gameplay-item mb-50">
        <div class="gameplay-thumb">
            <a href="https://www.youtube.com/watch?v=ssrNcwxALS4" class="popup-video">
                <img :src="require(`../assets/img/images/${filename}`)" alt="">
            </a>
            <div class="treand-gameplay-overlay">
                <ul>
                    <li class="quality">{{ title }}</li>
                </ul>
            </div>
        </div>
        <div class="d-block d-sm-flex align-items-start">
            <div class="gameplay-content">
                <h5 class="title"><a href="#">{{ title }}</a></h5>
                <div class="gameplay-meta">
                    <ul>
                        <li>Reputation score: 232</li>
                        <li>Rewards Token : {{ reward }}</li>
                        <li>Actual Price of the token : {{bnbPrice}} </li>
                    </ul>
                </div>
            </div>
            <div class="gameplay-status">
                <span>live</span>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  name: 'QuestsCard',
  props: ['filename', 'title', 'reward']
}
</script>

<style>

</style>