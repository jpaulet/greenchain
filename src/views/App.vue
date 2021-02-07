<template>
  <div class="" style='text-align:center;'>

    <!-- Nav -->
    <header id="main-header" data-height-onload="80" data-height-loaded="true" data-fixed-height-onload="80" style="top: 0px;box-shadow:0 0 3px #000;border-bottom:1px solid #eee;">
       <div class="container clearfix et_menu_container" style='padding-top:0px;'>
          <div style='float:left;'>
              <!-- <h1>GreenChain</h1> -->
              <img src='img/greenchain2.png' style='height: 48px; padding-top: 12px;margin-top: 6px;' />
          </div>

          <div id="et-top-navigation" data-height="66" data-fixed-height="40">
             <nav id="top-menu-nav">
                <ul id="top-menu" class="nav">
                   <li id="homeLink" class="menu-item">
                      <a href="/">Home</a>
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
                      <li class="menu-item">
                          <a href="/">Home</a>
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

    <b-container v-if="!walletConnected">
      <h1 class='mt-5 pt-5 mb-5 pb-5'> Greenblock</h1>
      <b-button @click="initWallet()" v-if='!walletConnected'>Connect</b-button>
    </b-container>


    <b-container v-if='walletConnected'>
      <div class='panel pricing-table pt-4 pb-4' style='flex-direction:row !important;'>
        <div class='col-3 textLight' style='border-right:1px solid #eee;'>
          <strong style='color:#666;'>Your Balance:</strong>
          <br />
          {{ user.balanceToEth | round(5) }} ETH
        </div>
        <div class='col-6 textLight'>
          <strong style='color:#666;'>Address:</strong>
          <br />
          <span>
            {{ getMaskedAddress() }} 
            <i class='fa fa-mark' data-toggle="tooltip" :title="user.addresss"></i>
          </span>
        </div>
        <div class='col-3 textLight' style='border-left:1px solid #eee;'>
          <strong style='color:#666;'>Transactions:</strong>
          <br />
          <strong>{{ user.txCount }}</strong>
        </div> 
      </div>
      <br /><br />

      <h3 class='mt-4'>Your Impact</h3>
      <div class='textLight mt-4 mb-4' style='font-size:16px;padding-left:10px;'>
        With your <strong>{{ getTxCount() }}</strong> transactions on the Blockchain, your climate impact is:
      </div>

      <div class='panel pricing-table'>
        <div class='pricing-plan'>
          <img clas='card-img-top' src='img/energy.jpg' alt='Kwh' style='height:120px;'>
          <div class='card-body'>
            <h5>{{ getKWh() }} kWh</h5>
          </div>
        </div>
        <div class='pricing-plan'>
          <img clas='card-img-top' src='img/co2.png' alt='Kwh' style='width:120px;height:120px;'>
          <div class='card-body'>
            <h5>{{ getCO2() }} kg of CO2</h5>
          </div>
        </div>
        <div class='pricing-plan'>
          <img clas='card-img-top' src='img/tonnes.jpg' alt='Kwh' style='width:120px;height:120px;'>
          <div class='card-body'>
            <h5>{{ getCO2Tonnes(2) }} tCO2</h5>
            <!-- <span v-if='(getCO2Tonnes(0) <== 1)' class='textLight'>(minimum of 1 tonne)</span> -->
          </div>
        </div>
      </div>

      <div class='d-flex justify-content-around mt-3'>
        <a class="textLight" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
          How it is calculated?
        </a>
        <a class="textLight" data-toggle="collapse" href="#collapseExample2" role="button" aria-expanded="false" aria-controls="collapseExample2">
          View what this CO2 looks like
        </a>
      </div>

      <div class="collapse mt-4 panel pricing-table py-5 text-left px-5" id="collapseExample" style='display:block;text-transform:none !important;'>
        <div class='row mt-2'>
          <strong>Electricity</strong>
          <div class='textLight mt-1 text-left' style='text-transform:none !important;'>
            We calculate emissions from electricity generation with the EPA’s eGRID emission factors based on 2018 data published in 2020, using the US average electricity source emissions of 0.947 lbs CO2e per kWh (0.429 kgs CO2e per kWh). 
            <br />Source: CarbonFund.
          </div>
        </div>

        <div class='row mt-5'>
          <strong>KG of Carbon</strong>
          <div class='textLight mt-1 text-left' style='text-transform:none !important;'>
            In our calculations, we convert kWh to kg of carbon released based on Greenhouse gas reporting: <a href='https://www.gov.uk/government/publications/greenhouse-gas-reporting-conversion-factors-2018' target='_blank'> conversion factors</a> from Department for Business, Energy and Industrial Strategy. The conversion factor is 0.28307 kg CO2 saved for each kWh produced from a carbon free source. The factor is based on the carbon emissions generated by the current UK power stations per kWh generated. This factor includes other green house gasses such as methane and nitrous oxide which are converted to their carbon dioxide equivalents so the value is really kg CO2 eq. per kWh. 
            <br />Source: https://www.rensmart.com/Calculators/KWH-to-CO2
          </div>
        </div>

        <div class='row mt-5'>
          <strong>Transactions (Ethereum)</strong>
          <div class='textLight mt-1 text-left justify-content-left' style='text-transform:none !important;'>
            The Ethereum Energy Consumption Index provides the latest estimate of the total energy consumption of the Ethereum network.

            <p class='text-left mt-3'>
              <strong>Annualized Total Electrical Energy:  10.49 TWh </strong><span class='text-lowercase'>(comparable to the power consumption of Georgia).</span>
            </p>
             
            <p class='text-left'><strong>Footprint per Single Transaction: 26-34 kWh</strong></p>
            Source: https://digiconomist.net/ethereum-energy-consumption
          </div>
        </div>
      </div>
      <div class="collapse mt-4 panel pricing-table py-5 text-left px-5" id="collapseExample2">
        <div class="row">
          <div class='col-12 text-center mb-4'>All this CO2 & kWh are equivalent to: </div>
          <div class="col-12 text-left" style='text-transform: none !important;'>
            <p class="text-left mb-0" style='text-transform:none !important;'>Washing Machine Load ({{ getLaundry }} laundries):</p>
            <span class="" v-for="index in getLaundry" :key="index">
              <img src="https://cdn2.iconfinder.com/data/icons/apartement-and-hotel-element/100/LAUNDRY-512.png" style='width:24px;height:24px;' />
            </span>
            <p style='text-align:center;font-size:12px;'>OR</p>

            <p class="text-left mt-4" style='text-transform:none !important;'>Charge Electric car: <strong>{{ getCar * 100 }} miles</strong></p>
            <p style='text-align:center;font-size:12px;'>OR</p>
            
            <p class="text-left" style='text-transform:none !important;'>Laptop: {{ getLaptop }}h. or <strong>{{ getLaptopDays }} complete days</strong> or <strong>{{ getLaptopDays / 365 | round(0) }} year/s</strong>:</p>
            <span class="" v-for="index in getLaptopDays" :key="'i' + index">
              <img src="https://www.iconarchive.com/download/i91777/icons8/windows-8/Time-Plus-1day.ico" style='width:24px;height:24px;padding:2px;opacity:0.5;' />
            </span>
          </div>
        </div>
      </div>

      <div class="mt-5 pt-5">
        <h3>Add Packs</h3>
      </div>
      <div class="grid mt-4">
        <label class="selectCard">
          <input class="selectCard__input" type="checkbox" v-model="pack1" />
          <div class="selectCard__body">
            <div class="selectCard__body-cover">
              <img class="selectCard__body-cover-image" src="img/green1.jpg"/>
              <span class="selectCard__body-cover-checkbox"> 
                <svg class="selectCard__body-cover-checkbox--svg" viewBox="0 0 12 10">
                  <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
                </svg>
              </span>
            </div>
            <header class="selectCard__body-header">
              <h4 class="selectCard__body-header-title">Validator</h4>
              <p class="selectCard__body-header-subtitle mb-3 pb-0">Offset your validator emissions</p>
              <!-- border-radius:8px;padding:5px;background-color:#64ac5ac95;color:#fff; -->
              <p class="selectCard__body-header-price" style="">+5 tCO2 - {{ this.getPack1Price() }}$</p>
            </header>
          </div>
        </label>
        <label class="selectCard">
          <input class="selectCard__input" type="checkbox" v-model="pack2" />
          <div class="selectCard__body">
            <div class="selectCard__body-cover">
              <img class="selectCard__body-cover-image" src="img/green3.jpg"/>
              <span class="selectCard__body-cover-checkbox"> 
                <svg class="selectCard__body-cover-checkbox--svg" viewBox="0 0 12 10">
                  <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
                </svg>
              </span>
            </div>
            <header class="selectCard__body-header">
              <h4 class="selectCard__body-header-title">Year</h4>
              <p class="selectCard__body-header-subtitle mb-3 pb-0">Offset your whole year</p>
              <p class="selectCard__body-header-price">+9 tCO2 - {{ this.getPack2Price() }}$</p>
            </header>
          </div>
        </label>
        <label class="selectCard">
          <input class="selectCard__input" type="checkbox" v-model="pack3" />
          <div class="selectCard__body">
            <div class="selectCard__body-cover">
              <img class="selectCard__body-cover-image" src="img/green2.jpg"/>
              <span class="selectCard__body-cover-checkbox"> 
                <svg class="selectCard__body-cover-checkbox--svg" viewBox="0 0 12 10">
                  <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
                </svg>
              </span>
            </div>
            <header class="selectCard__body-header">
              <h4 class="selectCard__body-header-title">100tx</h4>
              <p class="selectCard__body-header-subtitle mb-3 pb-0">Offset +100 tx</p>
              <p class="selectCard__body-header-price">+{{ (100 * kWh * co2Kg / 1000) | round(2) }} tCO2 - {{ this.getPack3Price() }}$</p>
            </header>
          </div>
        </label>
      </div>

      <br /><br /><br />

      <h3 id='buy' anchor='buy' class='mt-4 pt-5'>¡Act Now!</h3>
      <div class='textLight mt-4 mb-4' style='font-size:16px;padding-left:10px;'> 
        <strong>{{ this.co2Cost }}$</strong> for every <strong>1 tonne of CO2</strong> offseted. The total cost for offseting 100% of your emissions are <strong>{{ getTotalCost(2) }} $</strong>. Also, you will get <strong>{{ getCO2Tonnes(0) }} AIR</strong> tokens.
      </div>

      <div class="background">
        <div class="container pt-0">
          <div class="panel pricing-table">
            
            <div class="pricing-plan">
              <img src="img/green-energy-icon-3-1.png" alt="" class="pricing-img">
              <h2 class="pricing-header">Cleaner</h2>
              <ul class="pricing-features">
                <li class="pricing-features-item">Offsets 100% of your Blockchain transactions</li>
                <li class="pricing-features-item">Carbon Neutral</li>
                <li class="pricing-features-item">Get <strong>{{ getCO2Tonnes() }}</strong> AIR Token</li>
                <li v-if="pack1" class="pricing-features-item">+ Validator Pack ({{this.getPack1Price() }} $)</li>
                <li v-if="pack2" class="pricing-features-item">+ Year Pack ({{this.getPack2Price() }} $)</li>
                <li v-if="pack3" class="pricing-features-item">+ 100tx Pack ({{this.getPack3Price() }} $)</li>
              </ul>
              <span class="pricing-price">{{ getTotalCost(2) }}$</span>
              <span class='ml-3 mr-3 ethPrice'> {{ convertDollarsToPrice(getTotalCost()) | round(5) }} eth</span>
              <a href="#/" class="pricing-button col-12" @click='buyTokens(getCO2Tonnes())'>Buy</a>
              <span class='text-danger ethPrice' v-if="!hasEnoughtEth(getTotalCost())"> You don't have enought ETH in your wallet</span>
            </div>
            
            <div class="pricing-plan">
              <img src="img/green-energy-icon-7-1.png" alt="" class="pricing-img">
              <h2 class="pricing-header">Hero</h2>
              <ul class="pricing-features">
                <li class="pricing-features-item">Offsets 200% of your Blockchain transactions</li>
                <li class="pricing-features-item">Carbon Positive</li>
                <li class="pricing-features-item">Get {{ getTotalCost() / 12 | round(0)}} AIR Token</li>
                <li v-if="pack1" class="pricing-features-item">+ Validator Pack ({{this.getPack1Price() }} $)</li>
                <li v-if="pack2" class="pricing-features-item">+ Year Pack ({{this.getPack2Price() }} $)</li>
                <li v-if="pack3" class="pricing-features-item">+ 100tx Pack ({{this.getPack3Price() }} $)</li>                
              </ul>
              <span class="pricing-price">{{ getTotalCost(2) * 2}}$</span>
              <span class='ml-3 mr-3 ethPrice'> {{ convertDollarsToPrice(getTotalCost() * 2) | round(5) }} eth</span>
              <a href="#/" class="pricing-button is-featured col-12" @click='buyTokens( getTotalCost() / 12)'>Buy</a>
              <span class='text-danger ethPrice' v-if="!hasEnoughtEth(getTotalCost()*2)"> You don't have enought ETH in your wallet</span>
            </div>
            
            <div class="pricing-plan">
              <img src="img/green-energy-icon-13-1.png" alt="" class="pricing-img">
              <h2 class="pricing-header">Custom</h2>
              <ul class="pricing-features">
                <li class="pricing-features-item">Offset more than you consumed on the Blockchain!</li>
                <li class="pricing-features-item">Carbon Super Positive!</li>
                <li class="pricing-features-item">Get {{ (this.customCount / this.co2Cost) | round(2) }} AIR tokens</li>
                <li v-if="pack1" class="pricing-features-item">+ Validator Pack ({{this.getPack1Price() }} $)</li>
                <li v-if="pack2" class="pricing-features-item">+ Year Pack ({{this.getPack2Price() }} $)</li>
                <li v-if="pack3" class="pricing-features-item">+ 100tx Pack ({{this.getPack3Price() }} $)</li>
              </ul>
              <span class="pricing-price">
                <button type='button' class='btn btn-round' @click='sub10'>-</button>
                <span class='ml-3 mr-3'> {{ this.customCount }} $</span>
                <button type='button' class='btn btn-round' @click='add10'>+</button>
              </span>
              <span class="">
                <span class='ml-3 mr-3 ethPrice'> {{ convertDollarsToPrice(this.customCount) | round(5) }} eth</span>
              </span>
              <a href="#/" class="pricing-button col-12" @click='buyTokens((customCount/co2Cost))'>Buy</a>
              <span class='text-danger ethPrice' v-if="!hasEnoughtEth(this.customCount)"> You don't have enought ETH in your wallet</span>
            </div>
            
          </div>
        </div>
      </div>

      <div class='d-flex justify-content-around mt-3'>
        <a class="textLight" data-toggle="collapse" href="#collapseDetails" role="button" aria-expanded="false" aria-controls="collapseDetails">
          View Details
        </a>        
      </div>

      <div class="collapse mt-4 panel pricing-table py-5 text-left px-5" id="collapseDetails" style='display:block;text-transform:none;'>
        <div class='row' style='text-transform:none !important;'>
          <div class='col-12 text-left'>
            <h5 style='font-size:13px;'>Params: </h5>
            Your Transactions (tx): <strong>{{ getTxCount() }}</strong><br/>
            +1 TX for offseting the current operation.<br/>          
            +15% GreenChain Fee.<br/>
            (The Minimum offset is 1 tonne)<br /><br />

            <div class="text-center mt-5">
              <h5 style='font-size:13px;'>Final Calculation: </h5>
              {{ ((user.txCount+1) * 30 * 0.707 / 1000) > 1 ? ((user.txCount+1) * 30 * 0.707 / 1000) : 1 | round(2) }} Tones of CO2 * 12$ per Tonne + 15% fee = {{ 12 * ( ( 115 * ((user.txCount+1) * 30 * 0.707 / 1000) / 100) > 1 ? ( 115 * ((user.txCount+1) * 30 * 0.707 / 1000) / 100) : 1.15 ) | round(2) }} $
            </div>
          </div>
        </div>
      </div>      

    </b-container>

    <Footer />

  </div>
</template>

<script>
import Footer from "@/components/Footer.vue";

import Web3 from "web3";
import Web3Modal from "web3modal";
import WalletConnectProvider from "@walletconnect/web3-provider";
import Fortmatic from "fortmatic";
import Torus from "@toruslabs/torus-embed";
import { mapState } from 'vuex';

const providerOptions = {
  walletconnect: {
    package: WalletConnectProvider, // required
    options: {
      infuraId: "INFURA_ID" // required
    }
  },
  fortmatic: {
    package: Fortmatic, // required
    options: {
      key: "FORTMATIC_KEY" // required
    }
  },
  torus: {
    package: Torus, // required
    options: {
      networkParams: {
        host: "https://localhost:8545", // optional
        chainId: 1337, // optional
        networkId: 1337 // optional
      },
      config: {
        buildEnv: "development" // optional
      }
    }
  }
};

const web3Modal = new Web3Modal({
  network: "mainnet", // optional
  cacheProvider: false, // optional
  providerOptions // required
});

export default {
  name: 'App',
  components: {
    'Footer': Footer
  },
  data: function() {
    return {
      pack1: false,
      pack2: false,
      pack3: false,
      ethPrice: null,
      ethPriceTimestamp: null,
      infuraId: "3a4e7138de7b4b57989e22af1a8f5649",
      tokenCost: 1000000000000000,
      kWh: 30,
      co2Cost: 15,
      co2Kg: 0.707,
      fee: 15,
      customCount: 0,
      web3Provider: null,
      DappToken: null,
      DappTokenSale: null      
    }
  },
  computed: {
    getLaundry: function() { return this.$options.filters.round((this.getCO2()/0.943), 0 ); },
    getCar: function() { return this.$options.filters.round((this.getCO2()/7.926), 0 ); },
    getLaptop: function() { return this.$options.filters.round((this.getCO2()/0.014), 0 ); },
    getLaptopDays: function() { return this.$options.filters.round(((this.getCO2()/0.014)/24), 0 ); },
    ...mapState({
      user: 'user',
      walletConnected: 'walletConnected'
    })
  },
  created: function() {
    this.customCount = this.getTotalCost() * 3;
  },
  mounted: function(){
    this.$nextTick(() => {
      if(!this.walletConnected){
        this.$router.push({name: 'landing', params: null});
      }else{
        console.log("User: "+ JSON.stringify(this.user));
        this.initContracts();
      }
    });
  },
  methods: {
    async initWallet(){
      const provider = await web3Modal.connect();
      const web3 = new Web3(provider);
      this.web3Provider = provider;

      this.$store.commit('walletConnected');

      let user = {}
      user.accounts = await web3.eth.getAccounts();
      user.address = user.accounts[0];
      user.txCount = await web3.eth.getTransactionCount(user.address);
      user.balance = await web3.eth.getBalance(user.address);
      user.balanceToEth = web3.utils.fromWei(user.balance,'ether');
    
      this.$store.commit('addUserInfo',user);
    },

    getTxCount(decimals = 0){
      return this.$options.filters.round( this.user.txCount, decimals );
    },

    getKWh(decimals = 0){
      return this.$options.filters.round( this.getTxCount(decimals) * this.kWh, decimals );
    },

    getCO2(decimals = 0){
      return this.$options.filters.round( this.getKWh(decimals) * this.co2Kg, decimals );
    },

    getCO2Tonnes(decimals = 0){
      return ( 
        this.$options.filters.round( this.getCO2(decimals) / 1000, decimals ) < 1 
        ? 1 
        : this.$options.filters.round( this.getCO2(decimals) / 1000, decimals )
      );
    },

    getCO2Cost(decimals = 0){
      return this.$options.filters.round( this.getCO2(decimals) * this.co2Cost, decimals ); 
    },

    getTotalCost(decimals = 0){
      let co2Total = (this.getTxCount() + 1) * this.kWh * this.co2Kg;
      let co2Tonnes = ( co2Total / 1000 );
      let price = (co2Tonnes * this.co2Cost);

      if(this.pack1){
        price = price + this.getPack1Price();
      }

      if(this.pack2){
        price = price + this.getPack2Price();
      }

      if(this.pack3){
        price = price + this.getPack3Price();
      }

      price = 115 * price / 100;

      //this.customCount = this.$options.filters.round( 3 * ((price > this.co2Cost) ? price : (115 * this.co2Cost / 100)), decimals);      

      return this.$options.filters.round( ((price > this.co2Cost) ? price : (115 * this.co2Cost / 100)), decimals);
    },

    getPack1Price(){
      return this.$options.filters.round( (5 * this.getCO2Cost(2)) / 1000, 2);
    },

    getPack2Price(){
      return this.$options.filters.round( (9 * this.getCO2Cost(2)) / 1000, 2 );
    },

    getPack3Price(){
      return this.$options.filters.round( (100 * this.kWh * this.co2Cost) / 1000, 2 );
    },

    add10(){
      if(this.customCount > 1000){
        return false;
      }
      this.customCount = this.customCount + 10;
    },

    sub10(){
      if( (this.customCount - 10) < this.getTotalCost || (this.customCount - 10) < 0){
        return false;
      }
      this.customCount = this.customCount - 10;
    },

    getMaskedAddress(){
      return this.user.address.substr(0,12)+"..."+this.user.address.substr(-12);
    },

    getEthPrice(){
      let currentTimestamp = Math.floor(Date.now() / 1000);

      //Refresh every 5 min
      if(this.ethPrice !== null && (currentTimestamp - this.ethPriceTimestamp) < 300 ){
        return this.ethPrice;
      }

      const web3 = new Web3("https://kovan.infura.io/v3/"+this.infuraId);
      const aggregatorV3InterfaceABI = [{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"description","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint80","name":"_roundId","type":"uint80"}],"name":"getRoundData","outputs":[{"internalType":"uint80","name":"roundId","type":"uint80"},{"internalType":"int256","name":"answer","type":"int256"},{"internalType":"uint256","name":"startedAt","type":"uint256"},{"internalType":"uint256","name":"updatedAt","type":"uint256"},{"internalType":"uint80","name":"answeredInRound","type":"uint80"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"latestRoundData","outputs":[{"internalType":"uint80","name":"roundId","type":"uint80"},{"internalType":"int256","name":"answer","type":"int256"},{"internalType":"uint256","name":"startedAt","type":"uint256"},{"internalType":"uint256","name":"updatedAt","type":"uint256"},{"internalType":"uint80","name":"answeredInRound","type":"uint80"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"version","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}];
      const addr = "0x9326BFA02ADD2366b30bacB125260Af641031331";
      const priceFeed = new web3.eth.Contract(aggregatorV3InterfaceABI, addr);
      priceFeed.methods.latestRoundData().call().then((roundData) => {
          this.ethPrice = (roundData.answer/100000000 );
          this.ethPriceTimestamp = Math.floor(Date.now() / 1000);
      });
    },

    convertDollarsToPrice(dollars){
      // console.log("convertDollarsToPrice: "+dollars);
      this.getEthPrice();
      return dollars / this.ethPrice;
    },

    hasEnoughtEth(cost){
      // console.log("Cost: "+this.convertDollarsToPrice(cost)+" - User balance: "+this.user.balanceToEth);
      return (this.user.balanceToEth >= this.convertDollarsToPrice(cost));
    },

    async initContracts() {
      console.log("Init contracts... ");

      var DappToken = require("../assets/contracts/DappToken.json");
      var DappTokenSale = require("../assets/contracts/DappTokenSale.json");

      const web3 = new Web3(Web3.givenProvider);

      const networkId = await web3.eth.net.getId();
      const chainId = await web3.eth.getChainId();
      console.log("network id: "+networkId+" - chainId: "+chainId);
      
      this.dappToken = await new web3.eth.Contract(DappToken.abi,'0x09F4ed9F676b615CCD6D0346A42f4CC46463D3D9');
      this.dappTokenSale = await new web3.eth.Contract(DappTokenSale.abi, '0x511817bCDD661ee31a610255706bE3df43346B76');

      this.dappToken.setProvider(Web3.givenProvider);
      this.dappTokenSale.setProvider(Web3.givenProvider);
    },

    buyTokens(_numOfTokens){
      var numberOfTokens = _numOfTokens;
      var tokenPrice = this.convertDollarsToPrice(this.co2Cost);

      console.log("Num of tokens: "+numberOfTokens);
      console.log("TokenPrice:"+tokenPrice);
      console.log("Multi: "+ (numberOfTokens * tokenPrice));
      console.log("Multi to string: "+ (numberOfTokens * tokenPrice).toString());
      console.log("Value: "+web3.utils.toWei((numberOfTokens * tokenPrice).toString()));

      const web3 = new Web3(Web3.givenProvider);
      let options = {
        from: this.user.address,
        value: web3.utils.toHex(web3.utils.toWei((numberOfTokens * tokenPrice).toString(), 'ether')),
        gas: web3.utils.toHex(500000) // Gas limit
        //gasLimit
        //gasPrice
        //nonce
      }
      
      this.dappTokenSale.methods.buyTokens(numberOfTokens).send(options).then(function(result){
        console.log("bought tokens!"+ result);
      });
    },

    // Listen for events emitted from the contract
    listenForEvents() {
      this.DappTokenSale.Sell({}, {
        fromBlock: 0,
        toBlock: 'latest',
      }).watch(function(error, event) {
        console.log("event triggered", event);
        console.log('Event: ' + JSON.stringify(event[0].args));
      })    
    }  
  }
}
</script>

<style scoped>
@media (min-width: 900px) {
  .background {
    padding: 0 0 25px;
  }
}

.container {
  margin: 0 auto;
  padding: 50px 0 0;
  max-width: 960px;
  width: 100%;
  color:#000;
}

.panel {
  background-color: #fff;
  border-radius: 10px;
  padding: 15px 25px;
  position: relative;
  width: 100%;
  z-index: 10;
}

.pricing-table {
  box-shadow: 0px 10px 13px -6px rgba(0, 0, 0, 0.08),
    0px 20px 31px 3px rgba(0, 0, 0, 0.09), 0px 8px 20px 7px rgba(0, 0, 0, 0.02);
  display: flex;
  flex-direction: column;
}

@media (min-width: 900px) {
  .pricing-table {
    flex-direction: row;
  }
}

.pricing-table * {
  text-align: center;
  text-transform: uppercase;
}

.pricing-plan {
  border-bottom: 1px solid #9898983d;
  padding: 25px;
}

.pricing-plan:last-child {
  border-bottom: none;
}

@media (min-width: 900px) {
  .pricing-plan {
    border-bottom: none;
    border-right: 1px solid #9898983d;
    flex-basis: 100%;
    padding: 25px 50px;
  }

  .pricing-plan:last-child {
    border-right: none;
  }
}

.pricing-img {
  margin-bottom: 25px;
  max-width: 100%;
}

.pricing-header {
  color: #86A479;
  font-weight: 600;
  letter-spacing: 1px;
}

.pricing-features {
  color: #AFD04E;
  font-weight: 600;
  letter-spacing: 1px;
  margin: 50px 0 25px;
  padding: 0px;
}

.pricing-features-item {
  border-top: 1px solid #9898983d;
  font-size: 12px;
  line-height: 1.5;
  padding: 15px 0;
  list-style: none;
}

.pricing-features-item:last-child {
  border-bottom: 1px solid #9898983d;
}

.pricing-price {
  color: #86A479;
  display: block;
  font-size: 32px;
  font-weight: 700;
}

.pricing-button {
  border: 1px solid #86A479;
  border-radius: 10px;
  color: #86A479;
  display: inline-block;
  margin: 25px 0;
  padding: 15px 35px;
  text-decoration: none;
  transition: all 150ms ease-in-out;
}

.pricing-button:hover,
.pricing-button:focus {
  background-color: #9898983d;
}

.pricing-button.is-featured {
  background-color: #86A479;
  color: #fff;
}

.pricing-button.is-featured:hover,
.pricing-button.is-featured:active {
  background-color: #269aff;
}

.textLight{
  font-size:12px;
  color:#777;
}

.btn-round{
  border:1px solid #eee;
  border-radius: 28px;
  color:#86A479;
}
.collapse:not(.show) {
    display: none !important;
}
</style>
