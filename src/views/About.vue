<template>
  <div class="about">
    <Header />
    
    <h1>About</h1>

    <Footer />
  </div>
</template>

<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";

export default {
  name: 'About',
  components: {
    'Header': Header,
    'Footer': Footer
  },
  data: function() {
    return {}
  }
};
</script>