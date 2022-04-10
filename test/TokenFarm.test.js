const DaiToken = artifacts.require('DaiToken')
const DappToken = artifacts.require('DappToken')
const TokenFarm = artifacts.require('TokenFarm')

require('chai').use(require('chai-as-promised')).should()

function tokens(n){
    return web3.utils.toWei(n, 'Ether')
}

contract('TokenFarm', (accounts) => {

    let daiToken, dappToken, tokenFarm;
    before(async () => {
        // Load contracts
        daiToken = await DaiToken.new()
        dappToken = await DappToken.new()
        tokenFarm = await TokenFarm.new(dappToken.address, daiToken.address)

        // Transfer all dapp token to farm (1 million)
        await dappToken.transfer(tokenFarm.address,  tokens('1000000'))

        // Send tokens to investors
        await daiToken.transfer(accounts[1], tokens('100'), {from: accounts[0]})
    })

    // Tests
    describe('Mock DAI Deployment', async () => {
        it('has a name', async () => {
            const name = await daiToken.name()
            assert.equal(name, 'Mock DAI Token')
        })
    })
})