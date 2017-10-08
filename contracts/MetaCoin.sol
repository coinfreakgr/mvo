pragma solidity ^0.4.15;

import 'zeppelin-solidity/contracts/token/ERC20Basic.sol';
import 'zeppelin-solidity/contracts/token/StandardToken.sol';

contract MVOIco is StandardToken {
    using SafeMath for uint256;

    string  public name = "My Vivid Omagination Token";
    string  public symbol = "MVO";
    uint  public decimals = 18;
    uint256 public totalSupply =  21000000 * (uint256(10) ** decimals);
    uint256 public price;
    address public owner;
    uint256 public endTime;

    modifier during_ico(){
      if (now >= endTime){
        revert();
      }else{
        _;
      }
    }

    function () payable during_ico {
      createTokens(msg.sender);
    }

    function createTokens(address recipient) payable {
      if (msg.value == 0) {
        revert();
      }

      uint tokens = SafeMath.div(SafeMath.mul(msg.value, price), 1 ether);
      totalSupply = SafeMath.add(totalSupply, tokens);

      balances[recipient] = SafeMath.add(balances[recipient], tokens);

      if (!owner.send(msg.value)) {
        revert();
      }
    }

    function MVOIco() {
        totalSupply = totalSupply;
        endTime = now + 8 weeks;
        price   = 200;
        balances[msg.sender] = totalSupply;
        owner   = msg.sender;
    }

  }
