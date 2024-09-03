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

    // Hàm để gửi TON tokens đến một địa chỉ khác
    function sendTON(address recipient, uint128 amount) public {
        require(msg.sender == owner, "Only the owner can send TON");
        require(amount <= address(this).balance, "Insufficient balance");

        // Gửi TON tokens, không cần dùng thêm tham số false trong TON
        recipient.transfer(amount, true, 3); // 3 là chỉ định của TON để gửi toàn bộ số dư còn lại sau khi trừ phí
    }

    // Hàm để tương tác với một hợp đồng khác
    function interactWithContract(address contractAddress, uint newValue) public {
        require(msg.sender == owner, "Only the owner can interact with other contracts");

        // Gọi hàm `setValue` của hợp đồng khác
        MyTONContract(contractAddress).setValue{value: 1 ton}(newValue); // Truyền giá trị 1 ton để trả phí gas cho cuộc gọi
    }
}
    // Hàm để tự hủy hợp đồng và gửi toàn bộ số dư còn lại cho chủ sở hữu
    function destroyContract() public {
        require(msg.sender == owner, "Only the owner can destroy the contract");
        emit ContractDestroyed(owner, address(this).balance);
        selfdestruct(owner);
    }
}
