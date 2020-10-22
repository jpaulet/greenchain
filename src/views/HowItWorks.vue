<template>
  <div id="page-container"> 
    <Header />
  How it works
    <Footer />
  </div>
</template>

<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";

export default {
  name: 'HowItWorks',
  components: {
    'Header': Header,
    'Footer': Footer
  },
  data: function() {
    return {}
  }
};
</script>