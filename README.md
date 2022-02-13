# SOLIDITY FUNCTION KEYWORDS


In this article, we will learn 
* Visibility keywords which are Public, External, Private and Public, 
* Pure, Payable and View
* Override and Virtual
 
&nbsp;

## VISIBILTY KEYWORDS :  Public, External, Private and Public


### Public vs External 

* public : all contracts can access

* external : Cannot be accessed internally, only externally contracts access


both public and external can reach from another contract


```solidity

contract MyContract {
      
    function reachPublicFunction() public {
        AnotherContract anotherContract = new AnotherContract();
        anotherContract.somePublicFunc();
    }
    
    
    function reachExternalFunction() public {
        AnotherContract anotherContract = new AnotherContract();
        anotherContract.somePublicFunc();
    }

}
```

but we cannot reach external functions internally

```solidity
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
```

### Private vs Internal

internal functions can be reachable from derived instances but privates cant
 
We have a Parent Contract like this

```solidity
contract Parent {
    
    function somePrivateFunc() pure private returns(string memory) {
        return "Hello Solidity";
    }

    function someInternalFunc() pure internal returns(string memory) {
        return "Hello Solidity";
    }
}
```

you can see the contract parent is inherited by the contract child, and someInternalFunc() cannot be reachable from the child contract 

```solidity
contract Child  is Parent {


    function reachInternalFunc() pure public {
        someInternalFunc();
    }

    function reachPrivateFunc() pure public {
        //somePrivateFunc();
        ///compiler returns =>  Undeclared identifier.
    }

}

```


&nbsp;

## Pure, Payable and View


### Pure

we can't reach or modify contract's variables on pure functions
    
```solidity
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
```

### View

we can only read contract's variables, can't modify

```solidity

function viewDemo() public view  returns(uint256) {
        //variableOne = 30;
        /// compiler returns that error 
        ///"Function declared as view, but this expression (potentially) modifies the state and thus requires non-payable (the default) or payable."

        //correct usage
        return variableOne+variableTwo;
    }
    
```


### Payable

to receive or send ethers, use payable modifier

```solidity

 function payableDemo() public payable returns(uint256)  {

      //without payable modifier, compiler returns that error 
      //"msg.value" and "callvalue()" can only be used in payable public functions. Make the function "payable" or use an internal function to avoid this error.  
      return msg.value;
    }
    
   
```



&nbsp;

## Override and Virtual 

Solidity is an OOP language , so functions supports overriding. 
 
to override sayHello() function, we must declare it as a virtual

```solidity
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
```

