Oysterpump 🦪

A decentralized game built on the Sui blockchain where players can try their luck to mint exclusive NFTs.

## Overview

Oysterpump is a blockchain-based game that implements a fair and transparent pearl finding mechanism. 1 out of 6 will produce a pearl.

## Features

- **Fair Random Number Generation**: Utilizing Sui's native random number generator
- **NFT Rewards**: Automatic NFT minting for lucky schucks

## Smart Contract Functions

### `try_luck`
The main game function where players:
- Automatically receive an NFT pearl if they get randomly a 6
- All recorded on-chain regardless of the outcome

## Technical Stack

- Language: Move
- Platform: Sui Blockchain
- Dependencies: 
  - `sui::random`
  - `sui::event`
  - `sui::object`
  - `sui::transfer`
Interfcace will be available at oysterpump.com
