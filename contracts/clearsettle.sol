// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract ClearSettle is ReentrancyGuard {
    IERC20 public immutable token;

    struct Milestone {
        uint256 amount;
        bool released;
        address validator; // AI Agent
    }

    struct Agreement {
        address payer;
        address payee;
        uint256 balance;
        Milestone[] milestones;
    }

    mapping(uint256 => Agreement) public agreements;
    uint256 public nextAgreementId;

    event AgreementCreated(uint256 id);
    event MilestoneReleased(uint256 id, uint256 milestoneIndex);

    constructor(address _token) {
        token = IERC20(_token);
    }

    function createAgreement(
        address _payee,
        uint256[] calldata _amounts,
        address[] calldata _validators
    ) external nonReentrant {
        require(_amounts.length == _validators.length, "Length mismatch");

        uint256 total;
        for (uint256 i = 0; i < _amounts.length; i++) {
            total += _amounts[i];
        }

        require(token.transferFrom(msg.sender, address(this), total), "Transfer failed");

        Agreement storage ag = agreements[nextAgreementId];
        ag.payer = msg.sender;
        ag.payee = _payee;
        ag.balance = total;

        for (uint256 i = 0; i < _amounts.length; i++) {
            ag.milestones.push(
                Milestone({
                    amount: _amounts[i],
                    released: false,
                    validator: _validators[i]
                })
            );
        }

        emit AgreementCreated(nextAgreementId);
        nextAgreementId++;
    }

    function releaseMilestone(uint256 _id, uint256 _mIndex) external nonReentrant {
        Agreement storage ag = agreements[_id];
        Milestone storage ms = ag.milestones[_mIndex];

        require(!ms.released, "Already released");
        require(msg.sender == ms.validator, "Not validator");

        ms.released = true;
        ag.balance -= ms.amount;

        require(token.transfer(ag.payee, ms.amount), "Payment failed");

        emit MilestoneReleased(_id, _mIndex);
    }
}
