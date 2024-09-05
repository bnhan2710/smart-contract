pragma ton-solidity >= 0.45.0;

contract MyTONContract {
    // Biến lưu trữ số lượng TON tokens
    uint public storedValue;

    // Địa chỉ của chủ sở hữu hợp đồng
    address public owner;

    // Sự kiện được kích hoạt khi giá trị được cập nhật
    event ValueUpdated(uint newValue);

    // Hàm khởi tạo (constructor) để đặt chủ sở hữu hợp đồng
    constructor() public {
        owner = msg.sender; // msg.sender là người gọi hợp đồng
    }

    // Hàm để đặt giá trị mới
    function setValue(uint value) public {
        require(msg.sender == owner, "Only the owner can set the value");
        storedValue = value;
        emit ValueUpdated(value); // Kích hoạt sự kiện
    }

    // Hàm để nhận TON tokens
    receive() external payable {
        // msg.value chứa số TON tokens được gửi
    }

    // Danh sách địa chỉ được phép tương tác với hợp đồng
    mapping(address => bool) public whitelist;

    // Sự kiện khi một địa chỉ được thêm vào whitelist
    event AddressWhitelisted(address indexed account);

    // Hàm để thêm địa chỉ vào whitelist
    function addToWhitelist(address account) public {
        require(msg.sender == owner, "Only the owner can modify the whitelist");
        whitelist[account] = true;
        emit AddressWhitelisted(account); // Kích hoạt sự kiện khi một địa chỉ được thêm
    }

    // Hàm để xóa địa chỉ khỏi whitelist
    function removeFromWhitelist(address account) public {
        require(msg.sender == owner, "Only the owner can modify the whitelist");
        whitelist[account] = false;
    }

    // Hàm để gửi TON tokens đến một địa chỉ khác
    function sendTON(address recipient, uint128 amount) public {
        require(msg.sender == owner, "Only the owner can send TON");
        require(whitelist[recipient], "Recipient is not whitelisted");
        require(amount <= address(this).balance, "Insufficient balance");

        // Gửi TON tokens
        recipient.transfer(amount, true, 3); // 3 là chỉ định của TON để gửi toàn bộ số dư còn lại sau khi trừ phí
    }

    // Hàm để tương tác với một hợp đồng khác
    function interactWithContract(address contractAddress, uint newValue) public {
        require(msg.sender == owner, "Only the owner can interact with other contracts");

        // Gọi hàm `setValue` của hợp đồng khác
        MyTONContract(contractAddress).setValue{value: 1 ton}(newValue); // Truyền giá trị 1 ton để trả phí gas cho cuộc gọi
    }
}
