// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;



contract FunctionModifiersTutorial {


    uint256 variableOne = 10;
    uint256 variableTwo = 20;


    // we can't reach or modify contract's variables on pure functions
    function pureDemo() public pure  returns(uint256) {
        //uint newVariable = variableOne; 
        ///returns that error "Function declared as pure, but this expression (potentially) reads from the environment or state and thus requires "view"."
        
        //variableOne = 30;
        /// returns that error "Function declared as pure, but this expression (potentially) modifies the state and thus requires non-payable (the default) or payable."

        //correct usage
        uint256 var1 =3;
        uint256 var2 = 4;
        return var1+var2;
    }

    // we can only read contracts variables, can't modify
    function viewDemo() public view  returns(uint256) {
        //variableOne = 30;
        /// returns that error "Function declared as view, but this expression (potentially) modifies the state and thus requires non-payable (the default) or payable."

        //correct usage
        return variableOne+variableTwo;
    }

    
    
    // to receive or send ethers, use payable modifier
    function payableDemo() public payable returns(uint256)  {

      //without payable modifier, compiler returns that error 
      //"msg.value" and "callvalue()" can only be used in payable public functions. Make the function "payable" or use an internal function to avoid this error.  
      return msg.value;
    }





}

///VISIBILTY MODIFIERS

contract MyContract {
      
    //public - all contracts can access
    function reachPublicFunction() public {
        AnotherContract anotherContract = new AnotherContract();
        anotherContract.somePublicFunc();
    }
    
    //external - Cannot be accessed internally, only externally contracts access
    function reachExternalFunction() public {
        AnotherContract anotherContract = new AnotherContract();
        anotherContract.somePublicFunc();
    }

    //internal - only this contract and contracts deriving from it can access

    //private - can be accessed only from this contract
}


contract AnotherContract {

    function someExternalFunc() pure external returns(string memory) {
        return "Hello Solidity";
    }

     function reachExternalFunc() pure public returns(string memory) {
        //someExternalFunc();
        //compiler returns =>  Undeclared identifier.
        return "Hello Solidity";
    }

    function somePublicFunc() pure public returns(string memory) {
        return "Hello Solidity";
    }

   
}


contract Parent {
    
    function somePrivateFunc() pure private returns(string memory) {
        return "Hello Solidity";
    }

    function someInternalFunc() pure internal returns(string memory) {
        return "Hello Solidity";
    }
}

contract Child  is Parent {


    function reachInternalFunc() pure public {
        someInternalFunc();
    }

    function reachPrivateFunc() pure public {
        //somePrivateFunc();
        ///compiler returns =>  Undeclared identifier.
    }

}


contract Greeting {

    function sayHello() public pure virtual returns(string memory){
        //without virtual keyword compiler returns that Error
        //TypeError: Trying to override non-virtual function. Did you forget to add "virtual"?
        return "Hello";
    }

}

contract Hello is Greeting {

    function sayHello() public pure override returns(string memory){
        return "Hello Solidity";        
    }
    
}


