// const { expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const Token = artifacts.require('TokenJonLiu.sol');

contract('TokenJonLiu', accounts => {
    let token; 
    const initialBalance = web3.utils.toBN(web3.utils.toWei('1'));

    beforeEach(async () => {
        token = await Token.new('TokenJonLiu', 'LWS', 1000000);
    });

    // it('should have an initial supply of 1,000,000 tokens', async () => {
    //     const balance = await token.balanceOf
    // });

    it('should mint 1,000,000 more tokens', async () => {
        const testAddress = '0xf1c463aB9791911D7CF896BFB994cB157E6d441B';
        const amount = 1000000;
        const mintedTokens = await token.mint(testAddress, amount);
        // Testing change assert statement
        assert.equal(
            mintedTokens, 
            1000000,
            "Total supply after minting not equal to 2 million tokens"
        );
        // assert(mintedTokens.equal(1000000));
    });
});