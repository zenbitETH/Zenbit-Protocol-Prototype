const Zenbit = artifacts.require("ZenbitRewards");

module.exports = function(deployer, accounts) {
    console.log(accounts)
    deployer.deploy(Zenbit, "", "Zenbit");
}