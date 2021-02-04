<template>
  <div id="page-container"> 
    
    <!-- Nav -->
    <header id="main-header" data-height-onload="80" data-height-loaded="true" data-fixed-height-onload="80" style="top: 0px;box-shadow:0 0 3px #000;border-bottom:1px solid #eee;">
       <div class="container clearfix et_menu_container" style='padding-top:0px;'>
          <div style='float:left;'>
              <!-- <h1>GreenChain</h1> -->
              <img src='img/greenchain2.png' style='height:60px;padding-top:12px;' />
          </div>

          <div id="et-top-navigation" data-height="66" data-fixed-height="40">
             <nav id="top-menu-nav">
                <ul id="top-menu" class="nav">
                   <li id="homeLink" class="menu-item current-menu-item current_page_item">
                      <a href="/" aria-current="page">Home</a>
                   </li>
                   <li id="howitWorksLink" class="menu-item">
                      <a href="how-it-works">How It Works</a>
                   </li>
                   <li id="aboutLink" class="menu-item">
                      <a href="about">About</a>
                   </li>
                   <li id="leaderboardLink" class="menu-item">
                      <a href="leaderboard">Leaderboard</a>
                   </li>
                   <li id="contactLink" class="menu-item">
                      <a href="contact">Contact</a>
                   </li>
                   <li>
                      <button class="btnRoundGreen" style='margin-top:-24px;' @click.prevent="initWallet()">App ></button>
                   </li>
                </ul>
             </nav>

             <div id="et_mobile_nav_menu">
                <div class="mobile_nav closed">
                   <span class="select_page">Select Page</span>
                   <span class="mobile_menu_bar mobile_menu_bar_toggle"></span>
                   <ul id="mobile_menu" class="et_mobile_menu">
                      <li class="menu-item current-menu-item page_item current_page_item et_first_mobile_item">
                          <a href="" aria-current="page">Home</a>
                      </li>
                      <li class="menu-item">
                          <a href="how-it-works">How It Works</a>
                      </li>
                      <li class="menu-item">
                          <a href="about">About</a>
                      </li>
                      <li class="menu-item">
                          <a href="leaderboard">Leaderboard</a>
                      </li>
                      <li class="menu-item">
                          <a href="contact">Contact</a>
                      </li>
                      <li>
                          <a class="et_pb_button et_pb_custom_button_icon et_pb_button_0 et_pb_bg_layout_light" href="app" data-icon=">" @click.prevent="initWallet()">Connect</a>
                      </li>
                   </ul>
                </div>
             </div>
          </div>
       </div>
    </header>
    <!-- end Nav -->

    <!-- How It Works -->
    <div id='section1' class="et_pb_section et_pb_section_0 et_pb_with_background et_section_regular">
      <div class="et_pb_row et_pb_row_0">

         <div class="et_pb_column et_pb_column_1_2 et_pb_column_0  blend_mode">
            <div class="et_pb_module et_pb_text et_pb_text_0  et_pb_text_align_left et_pb_bg_layout_light">
               <div class="et_pb_text_inner mt-5">
                  <h1 style='font-size:3.3em;'> How It Works?</h1>
                  <p style='font-size:1.3em;margin-top:20px;'>
                    <strong>Greenchain</strong> provides an easy and quick way to offset all your Ethereum Blockchain emissions by purchassing carbon credits equivalents (or superiors) than your transactions. <br /><br />

                    Let's see how it all works! <br /><br />                    
                  </p>
               </div>
            </div>            
         </div>
         <div class="et_pb_column et_pb_column_1_2 et_pb_column_1  blend_mode et-last-child">
            <div class="et_pb_module et_pb_image">
                <span class=" ">
                    <img loading="lazy" src="img/howitworks.jpg" alt="" title="" class="wp-image-221950" width="auto" height="auto" style='height:650px;'>
                </span>
            </div>                
         </div>
      </div>

      <div class='text-center text-danger mt-5'>
        <strong>Disclaimer: This project is on BETA and in development, new features will be deployed soon. Use it at your own risk.</strong> 
      </div>
    </div>

    <div class="section">
      
    </div>
    
    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/Footer.vue";

export default {
  name: 'HowItWorks',
  components: {
    'Footer': Footer
  },
  data: function() {
    return {}
  }
};
</script>