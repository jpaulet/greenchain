<template>
  <div id="page-container">
    <Header />
  
  Contact

  <Footer />
  </div>
</template>


<script>
import Header from "@/components/Header.vue";
import Footer from "@/components/Footer.vue";

export default {
  name: 'Contact',
  components: {
    'Header': Header,
    'Footer': Footer
  },
  data: function() {
    return {}
  }
};
</script>