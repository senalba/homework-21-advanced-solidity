pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";



contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale{ 
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    
    //Minimum Investor Contribution
    //Maxumin Investor Contribution

    uint256 public investorMinCap = 0;
	uint256 public investorHardCap = 5000000000000000000;

	mapping(address => uint256) public contributions;
    
    constructor(
        uint256 rate,
        address payable wallet,
        KaseiCoin token,
        uint256 _cap
    )
      Crowdsale(rate, wallet, token)
    //   CappedCrowdsale(_cap)
      public
    {
        // constructor can stay empty
    }

    // function _preValidatePurchase(
    //     address _beneficiary,
    //     uint256 _weiAmount
    //     )
    //         internal
    //     {
    //         super._preValidatePurchase(_beneficiary, _weiAmount);
    //         uint256 _existingContribution = contributions[_beneficiary];
    //         uint256 _newContribution = _existingContribution.add(_weiAmount);
    //         require(_newContribution >= investorMinCap && _newContribution <= investorHardCap);
	//         contributions[_beneficiary] = _newContribution;     
    //     }
}


contract KaseiCoinCrowdsaleDeployer {
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    constructor (
        string memory name,
        string memory symbol,
        address payable wallet
    )
    public
    {
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        kasei_token_address = address(token);

        KaseiCoinCrowdsale kasei_crowdsale = 
            new KaseiCoinCrowdsale(1, wallet, token, 50000000000000000000);
        kasei_crowdsale_address = address(kasei_crowdsale);

        token.addMinter(kasei_crowdsale_address);
        token.renounceMinter();
    }
}
