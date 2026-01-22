# Smart-contract-learning

# Crowdfunding Factory Smart Contract

# Overview

This project implements a crowdfunding system using the factory pattern in Solidity.
A central contract (the mother contract) can deploy and track multiple independent crowdfunding campaigns (child contracts).

Each campaign:

accepts ETH contributions

enforces a minimum contribution amount (USD-based)

tracks funders and their contributions

allows only the campaign owner to withdraw funds

This design mirrors how real-world platforms manage multiple campaigns under one system.

# Architecture
# 1. Mother Contract (motherCampaign)

The mother contract acts as a factory and registry.

# Responsibilities:

Deploy new crowdfunding campaigns

Store and track addresses of all deployed campaigns

Restrict campaign creation to the platform owner

Each campaign created is a separate smart contract with its own balance and state.

# 2. Child Contract (childCampaign)

Each child contract represents a single crowdfunding campaign.

# Features:

Accepts ETH contributions from users

Enforces a minimum contribution value using USD conversion

Tracks unique funders and their total contributions

Allows only the campaign owner to withdraw collected funds

Prevents withdrawals when no funds exist

Each deployed campaign is fully independent from others.

# 3. Price Conversion Library (priceConvertor)

A reusable Solidity library used to:

Fetch ETH/USD price data from Chainlink

Convert ETH values to USD

Enforce a minimum USD contribution amount

Using a library improves code reuse, clarity, and gas efficiency.

# Key Concepts Demonstrated

Factory pattern in Solidity

Deploying contracts from another contract (new)

Access control with modifiers

Solidity libraries and using for

Chainlink price feeds

Handling ETH safely with call

Preventing duplicate funders

Contract-to-contract interaction

# Contract Flow

Deploy motherCampaign

Call createChild() to deploy a new campaign

Retrieve campaign address using getChildAddress(index)

Interact with the campaign using ChildCampaign at the deployed address:

fundMe() to contribute

withdraw() to withdraw (owner only)

Each campaign has its own ETH balance and funder list.

# Why This Project Matters

This project models real-world crowdfunding logic, similar to platforms where:

multiple campaigns run simultaneously

each campaign has independent rules and funds

a central system manages creation and discovery

It demonstrates practical smart contract architecture rather than a single monolithic contract.

# Tech Stack

Solidity ^0.8.24

Remix IDE

Chainlink Price Feeds

Ethereum-compatible networks

# Possible Improvements

Add campaign deadlines

Add funding goals

Enable refunds if goals are not met

Emit events for funding and withdrawals

Frontend integration

# Author

Built by Alpha Prime
Biomedical Engineer | Smart Contract Developer | Web3 Builde
