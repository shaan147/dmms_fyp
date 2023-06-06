// migrations/1_deploy_contract.js

const ds = artifacts.require("DMMS");

module.exports = function(deployer) {
  deployer.deploy(ds);
};