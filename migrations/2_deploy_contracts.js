var OffsToken = artifacts.require("./OffsToken.sol");
var Offseth = artifacts.require("./Offseth.sol");

module.exports = function(deployer) {
  deployer.deploy(OffsToken).then(function() {
    return deployer.deploy(Offseth, OffsToken.address);
  });
};