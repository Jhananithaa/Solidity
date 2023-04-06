// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InventoryManagement {
    
    struct Product {
        uint id;
        string name;
        uint quantity;
        uint price;
    }

    Product[] public products;
    mapping(uint => uint) public productIndex;

    event ProductAdded(uint id, string name, uint quantity, uint price);
    event ProductUpdated(uint id, uint quantity);
    event ProductRemoved(uint id);

    function addProduct(uint _id, string memory _name, uint _quantity, uint _price) public {
        require(productIndex[_id] == 0, "Product already exists");

        Product memory newProduct = Product({
            id: _id,
            name: _name,
            quantity: _quantity,
            price: _price
        });

        products.push(newProduct);
        productIndex[_id] = products.length;

        emit ProductAdded(_id, _name, _quantity, _price);
    }

    function updateProductQuantity(uint _id, uint _quantity) public {
        require(productIndex[_id] != 0, "Product does not exist");

        Product storage product = products[productIndex[_id]-1];
        product.quantity = _quantity;

        emit ProductUpdated(_id, _quantity);
    }

    function removeProduct(uint _id) public {
        require(productIndex[_id] != 0, "Product does not exist");

        uint indexToRemove = productIndex[_id]-1;
        uint lastIndex = products.length-1;

        products[indexToRemove] = products[lastIndex];
        products.pop();

        productIndex[_id] = 0;

        emit ProductRemoved(_id);
    }

    function getProduct(uint _id) public view returns(uint, string memory, uint, uint) {
        require(productIndex[_id] != 0, "Product does not exist");

        Product storage product = products[productIndex[_id]-1];
        return (product.id, product.name, product.quantity, product.price);
    }
}
