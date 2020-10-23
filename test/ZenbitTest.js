var ZenbitRewards = artifacts.require('ZenbitRewards');
const truffleAssert = require('truffle-assertions');
const BigNumber = require('bignumber.js');

let account_one;
let account_two;
let account_three;

contract('Zenbit Rewards', accounts => {

    account_one = accounts[0];
    account_two = accounts[1];
    account_three = accounts[2];
})

it('should return total supply', async () => {

    const contract = await ZenbitRewards.deployed()
    balanceUser = await contract.balanceOf.call(account_one, 1)
    const o = new BigNumber(balanceUser)
})

it('Minting for zBNT', async () => {

    const contract = await ZenbitRewards.deployed()
    balanceUser = await contract.balanceOf.call(account_two, 1)
    await contract.mint(account_two, 1, 50, [])
    balanceUser2 = await contract.balanceOf.call(account_two, 1)
    const before = new BigNumber(balanceUser)
    const after = new BigNumber(balanceUser2)
    assert.equal(before.toNumber() + 50, after.toNumber(), "Minting didn´t work")
})

it('Minting CS1 certificates', async () => {
    let tokenId = 2 
    const contract = await ZenbitRewards.deployed()
    balanceUser = await contract.balanceOf.call(account_two, tokenId)
    await contract.mint(account_two, tokenId, 1, [])
    balanceUser2 = await contract.balanceOf.call(account_two, tokenId)
    const before = new BigNumber(balanceUser)
    const after = new BigNumber(balanceUser2)
    assert.equal(before.toNumber() + 1, after.toNumber(), "Minting didn´t work")
})

it('Minting CS1 certificates in batch', async () => {
    let tokenId = 2 
    const contract = await ZenbitRewards.deployed()
    balanceUser = await contract.balanceOf.call(account_three, tokenId)
    await contract.mintBatch(account_three, [1, 2], [45, 1], [])
    balanceUser2 = await contract.balanceOf.call(account_three, tokenId)
    const before = new BigNumber(balanceUser)
    const after = new BigNumber(balanceUser2)
    assert.equal(before.toNumber() + 1, after.toNumber(), "Minting didn´t work")
})

