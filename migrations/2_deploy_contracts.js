var DappToken = artifacts.require("./DappToken.sol");
var DappTokenSale = artifacts.require("./DappTokenSale.sol");

module.exports = function(deployer) {
  deployer.deploy(DappToken, 100000000).then(function() {
    // Token price is 0.03 Ether
    var tokenPrice = 3000000000000;
    return deployer.deploy(DappTokenSale, DappToken.address, tokenPrice);
  });
};