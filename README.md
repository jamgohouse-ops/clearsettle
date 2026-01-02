##ClearSettle

Programmable Escrow & Settlement for AI-Assisted Commerce

ClearSettle is a programmable escrow and settlement layer built on Ethereum using MNEE (ERC-20). It enables enterprises, service providers, and AI agents to execute bank-like payment flows (escrow, milestone payouts, reconciliation) using smart contracts instead of manual intermediaries.

##Inspiration

In traditional banking, contracts state when a payment should occur, but banks only move money — they do not execute contractual logic. Escrow services are slow, manual, expensive, and difficult to audit.

As AI agents increasingly participate in commerce, there is no native financial infrastructure that allows autonomous, conditional, and verifiable settlement. ClearSettle was built to bridge that gap.

##What It Does

ClearSettle allows funds denominated in MNEE to be locked in escrow and released only when predefined milestones are validated.

Each milestone can be validated by:

A human auditor

A compliance role

Or an AI agent acting as an autonomous validator

Once validated, the smart contract releases the corresponding payment automatically.

##How It Works

A payer deposits MNEE into a ClearSettle escrow contract

The payer defines:

Milestone amounts

Validators (human or AI agents)

Funds remain locked until validation

Validators trigger milestone releases on-chain

All events are immutable, auditable, and traceable

This creates institutional-grade settlement without manual reconciliation.

##Architecture Overview

Actors

Payer (enterprise)

Payee (vendor / service provider)

Validator (AI agent or auditor)

ClearSettle Smart Contract

## 🚀 Deployed Contracts

### Testnet (Sepolia)
```
ClearSettle: [Pending deployment - will update in 1 hour]
MNEE Token:  0x8ccedbAe4916b79da7F3F612EfB2EB93A2bFD6cF
Etherscan:   [Link will be added after deployment]
```

### Local Testing
For local development, the deploy script automatically deploys a MockMNEE token.

## 💰 MNEE Integration

ClearSettle is built specifically for **MNEE (USD-backed stablecoin)** on Ethereum.

**MNEE Contract:** `0x8ccedbAe4916b79da7F3F612EfB2EB93A2bFD6cF`

### Why MNEE?
- ✅ **Stable value:** USD-pegged, no volatility
- ✅ **Programmable:** Perfect for smart contract escrow
- ✅ **Institutional-grade:** Designed for business use
- ✅ **Transparent:** All settlements auditable on-chain

### How We Use MNEE
1. **Funding:** Payers deposit MNEE into escrow contracts
2. **Holding:** MNEE remains locked until milestone validation
3. **Settlement:** MNEE automatically released to payee upon validation
4. **Transparency:** Every MNEE transfer recorded on Ethereum

## 🎯 Smart Contract Features

### Core Functions
```solidity
// Create escrow agreement with MNEE
createAgreement(address payee, uint256[] amounts, address[] validators)

// Validator releases milestone payment
releaseMilestone(uint256 agreementId, uint256 milestoneIndex)
```

### View Functions (for Frontend)
```solidity
getAgreement(uint256 id)           // Get agreement details
getMilestones(uint256 id)          // Get all milestones
getMilestone(uint256 id, uint256 index)  // Get single milestone
isPayer(uint256 id, address user)  // Check if user is payer
isPayee(uint256 id, address user)  // Check if user is payee
getTotalAgreements()               // Get total count
```

## 🧪 Testing

### Local Testing
```bash
# Start local Hardhat network
npx hardhat node

# In another terminal, run tests
npx hardhat test

# Or deploy locally
npx hardhat run scripts/deploy.js --network localhost
```

### Sepolia Testnet
```bash
# Deploy to Sepolia
npx hardhat run scripts/deploy.js --network sepolia

# Verify contract
npx hardhat verify --network sepolia <CONTRACT_ADDRESS> <MNEE_ADDRESS>
```

## 📊 Contract Security

### Security Features
- ✅ **ReentrancyGuard:** Prevents reentrancy attacks
- ✅ **Access Control:** Only validators can release milestones
- ✅ **Immutable Token:** MNEE address cannot be changed
- ✅ **Event Logging:** All actions emit events for transparency
- ✅ **Input Validation:** All parameters validated before execution

### Auditing
- Built with OpenZeppelin battle-tested contracts
- Follows best practices from ConsenSys Smart Contract Best Practices
- Ready for professional audit

## 🏗️ Integration Example

### For AI Agents
```javascript
// AI Agent verifies deliverable and releases payment
const agent = new ethers.Wallet(AGENT_PRIVATE_KEY, provider);
const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, agent);

// Verify deliverable (off-chain)
const isValid = await verifyDeliverable(agreementId, milestoneIndex);

if (isValid) {
  // Release payment on-chain
  const tx = await contract.releaseMilestone(agreementId, milestoneIndex);
  await tx.wait();
  console.log("✅ Payment released");
}
```

### For DAOs
```javascript
// DAO treasury creates escrow for contractor
const amounts = [ethers.utils.parseUnits("10000", 18)]; // 10K MNEE
const validators = [DAO_MULTISIG_ADDRESS];

await mneeToken.approve(CONTRACT_ADDRESS, totalAmount);
await contract.createAgreement(CONTRACTOR_ADDRESS, amounts, validators);
```

## 🎯 Hackathon Compliance

### MNEE Usage ✅
- Contract explicitly uses MNEE token
- MNEE address documented and hardcoded for security
- All escrow and settlement operations use MNEE
- Deployed on Ethereum (MNEE's native chain)

### Track: AI & Agent Payments ✅
- Validators can be AI agent addresses
- Autonomous milestone validation
- No human intervention required for release
- Enables AI-to-AI commerce

### Track: Programmable Finance & Automation ✅
- Milestone-based automatic payouts
- Programmable settlement conditions
- Eliminates manual reconciliation
- Smart contract enforces agreement terms

#Core Components

Ethereum smart contract

MNEE (ERC-20) as settlement asset

Hardhat development environment

OpenZeppelin security libraries

##MNEE Usage

ClearSettle uses MNEE (ERC-20 on Ethereum) as the settlement currency.

Official MNEE contract:

0x8ccedbAe4916b79da7F3F612EfB2EB93A2bFD6cF


MNEE is:

Deposited into escrow

Locked until milestone validation

Released automatically per milestone

#Tracks

Track: Programmable Money / Institutional Finance

##Demo

This project runs on a local Hardhat network.

Judges can reproduce the demo by:

Deploying the ClearSettle contract

Creating an agreement

Releasing milestones

Observing MNEE transfers on-chain

A demo video (≤ 5 minutes) is provided in the Devpost submission.

##Getting Started
Prerequisites

Node.js (v18+)

npm

Installation
git clone https://github.com/your-username/clearsettle.git
cd clearsettle
npm install

Compile Contracts
npx hardhat compile

Start Local Network
npx hardhat node

Deploy Contract
npx hardhat run scripts/deploy.js --network localhost

##Smart Contract Features

ERC-20 escrow using MNEE

Milestone-based payouts

Validator-restricted release

Reentrancy protection

Immutable audit trail

##Third-Party Tools & Libraries

Hardhat

OpenZeppelin Contracts

Ethereum

No external APIs are used.

##Challenges We Ran Into

Designing milestone-based settlement logic that is flexible yet secure

Ensuring validator-only release without introducing trust assumptions

Balancing institutional UX with on-chain constraints

##Accomplishments

Built a fully functional programmable escrow

Integrated institutional payment logic using MNEE

Enabled AI-compatible settlement flows

Delivered a reproducible on-chain demo

##What We Learned

Financial coordination problems are better solved with code than paperwork

Smart contracts can replicate and improve traditional banking primitives

AI agents require deterministic financial infrastructure to operate safely

##What’s Next

Oracle-based validation for AI agents

Dispute resolution modules

Institutional dashboards

Mainnet pilot with enterprise users

License

MIT License

🔍 Juror Note

ClearSettle is not a consumer crypto app. It is programmable financial infrastructure designed for enterprise and AI-driven commerce using MNEE as a native settlement layer.
