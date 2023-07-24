// Solidity를 사용하기 위해 버전을 설정한다. [새로운 버전이 나왔을 때 코드가 깨지는 것을 방지]
pragma solidity ^0.4.19;

// 모든 코드는 contract 안에 위치한다.
contract ZombieFactory {

    // event가 실행되면 입력한 코드를 동작
    event NewZombie(uint zombieId, string name, uint dna);

    // 변수를 설정하여 블록체인에 영구적으로 기록 [uint 타입의 dnaDigits에 변수 16을 지정 / dnaModulus에 10의 16승을 지정]
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Zombie 구조체를 생성하여 uint 타입의 dna와 string 타입의 name가 포함되어 있다.
    // name -> 좀비의 이름을 저장 / dna -> 입력받은 정수를 저장
    struct Zombie {
        string name;
        uint dna;
    }
    // Zombie 구조체를 선언하여 생성된 데이터를 저장한다.
    Zombie[] public zombies;

    // _createZombie 함수는 name과 dna의 정보를 입력받아 새로운 좀비를 생성한다.
    // _는 private를 사용할 경우 사용되는데 함수를 공개하지 않는다. [솔리디티는 기본적으로 public 함수를 사용]
    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    }
    
    // _generateRandomDna 함수에 문자열 _str을 이용하여 랜덤한 dna 값을 생성한다.
    // 이후 dnaModulus로 나눈 나머지의 값을 반환한다.
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    // _generateRandomDna에서 랜덤한 dna를 호출하고 createRandomZombie에 이름과 dna값을 받아와 새로운 좀비를 생성한다.
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}