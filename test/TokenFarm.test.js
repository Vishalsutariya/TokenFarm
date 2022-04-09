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
        //load contracts
        daiToken = await DaiToken.new()
        dappToken = await DappToken.new()
        tokenFarm = await TokenFarm.new(dappToken.address, daiToken.address)

        // transfer all dapp token to farm (1 million)
        await dappToken.transfer(tokenFarm.address,  tokens('1000000'))
    })

    //tests
    describe('Mock DAI Deployment', async () => {
        it('has a name', async () => {
            const name = await daiToken.name()
            assert.equal(name, 'Mock DAI Token')
        })
    })
})