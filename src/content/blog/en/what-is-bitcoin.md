---
title: "What is Bitcoin and Why Was It Created?"
description: "An in-depth explanation of why Satoshi Nakamoto created Bitcoin as a response to the problems with fiat currency"
pubDate: 2023-08-07T00:00:00.000Z
author: "Enogtyve Team"
tags: ["bitcoin", "basics", "satoshi", "technology"]
language: "en"
---

# What is Bitcoin and Why Was It Created?

## Fiat currency
The post-1971 fiat currency system requires trust at every level, because it's debt-based and lacks an important element: scarcity. This includes trust in the ability to repay debt in the future, trust that commercial and central banks won't devalue the currency, and trust that they'll let people have access and freedom to use their funds and make transactions.

This trust has been violated numerous times, including during the global financial crisis of 2008/09. To address these problems, Satoshi Nakamoto set out to create a digital form of money that didn't require trust in third parties and that couldn't be devalued by a central authority issuing more units.

In announcing the project, Satoshi Nakamoto gave an explanation that goes roughly like this:

> The root problem with conventional currency is all the trust that's required to make it work. The central bank must be trusted not to debase the currency, but the history of fiat currencies is full of breaches of that trust. Banks must be trusted to hold our money and transfer it electronically, but they lend it out in waves of credit bubbles with barely a fraction in reserve.

## Money creation and credit expansion
Excessive money creation and credit expansion can cause numerous social and economic problems, including bubbles in stock and property markets that tend to undergo corrections roughly every decade.

While those closest to the source of new money often benefit greatly from these cycles, low-income individuals who don't own valuable assets and depend on regular paychecks are often the most affected by the inflation and the economic ups and downs that result from the fiat currency system.

A well-known example of this is the global financial crisis that began in 2008. Prior to this crisis, there had been a significant accumulation of debt and risk in the commercial banking sector.

## Why did Satoshi create Bitcoin?
It becomes clear why Satoshi Nakamoto created Bitcoin when we examine the first block in the Bitcoin blockchain, called the Genesis block.

This block was created by Satoshi when he launched Bitcoin in 2009, and it includes a reference to banks that received bailouts after the global financial crisis of 2008/09.

> "The Times 03/Jan/2009 Chancellor on the brink of second bailout for banks"

This crisis, in which trust in traditional financial systems was severely damaged, inspired Satoshi to create a digital form of money. This form of money doesn't require trust in third parties for transactions and can't be devalued by a central authority issuing more units.

## Satoshi Nakamoto
The creator of Bitcoin, who used the pseudonym "Satoshi Nakamoto", is unknown, and no claims to be the creator have been verified. Satoshi was only involved in the project for a short time before disappearing.

The Bitcoin protocol is based on open source code, which means anyone can review it. This transparency makes it the most reviewed codebase ever. Despite the mystery surrounding Bitcoin's creator, Bitcoin itself is an open and transparent monetary network that can be examined and used by anyone.

## The double-spending problem
In the digital world it's easy to copy things, so it's important to ensure that the same digital unit of money can't be spent more than once by its owner.

In a monetary system with a central authority, like a government, this problem is solved trivially by keeping a record of transactions managed by the central authority. But this usually represents a single point of failure from both an availability and a trust perspective.

In a decentralized system, the double-spending problem is significantly harder to solve. Many people have tried to create digital currency not controlled by a government, but they have all had their own unique challenges.

Satoshi Nakamoto took all these lessons into account and was the first to solve the double-spending problem with the implementation of Bitcoin, by creating a decentralized system that rewards honesty and makes dishonesty very costly.

## What came before the creation of Bitcoin?
Bitcoin is the result of decades of research by a group of individuals who call themselves Cypherpunks. They're interested in using cryptography to promote privacy and security in a world where increasing surveillance in the digital age can lead to less freedom.

Earlier digital money systems built on peer-to-peer (P2P) networks often had one or both of the following problems:

- They required a central authority to manage the ownership record.
- The currency units could be copied, resulting in the "double-spending problem," where a single unit could be spent multiple times.

Satoshi addressed both of these problems by combining existing technologies in the creation of Bitcoin. The first problem is solved because the decentralized nature of the Bitcoin network means there's no central authority that users have to trust. The second problem is addressed because the unique cryptographic techniques used in Bitcoin make it impossible to copy the currency units.

## Nodes
To tackle problems of centralization and solve the double-spending problem, Satoshi devised a solution based on a decentralized network of nodes.

Nodes are computers that are constantly in contact with each other. This in itself is nothing new. The internet has a similar infrastructure of interconnected nodes.

Every Bitcoin node keeps a copy of the record of all transactions in the Bitcoin network's history.

This new, decentralized form of bookkeeping, called a blockchain, was first successfully implemented in Bitcoin and is extremely resistant to tampering.

## Bitcoin Blockchain
The Bitcoin blockchain is a distributed database that maintains a continuously growing list of bitcoin transactions called blocks.

Blocks are anchored to each other through the use of cryptographic hashes. Each block contains a cryptographic hash of the previous block, along with a timestamp and transaction data. This creates a chain of blocks all linked together, where each block builds on the previous one.

The cryptographic hash function ensures that once a block has been added to the chain, it can't be changed or replaced without also changing all the subsequent blocks in the chain.

This creates a tamper-evident record of all transactions that have taken place on the blockchain, which can be used to verify the integrity of the data stored on the chain.

## Asymmetric cryptography / key-pair cryptography
Another cornerstone of Bitcoin is asymmetric cryptography, also called key-pair cryptography, which uses a pair of keys — a public key and a private key — to sign transactions and verify ownership of Bitcoin addresses.

The private key is a long string of characters used to authorize Bitcoin transactions. It's often represented as a combination of 12 words (sometimes 24). Only in the correct order do the words produce the corresponding private key.

Whoever knows the private key to a bitcoin address can control the bitcoin in that address. That's why it's important to keep it secret and never share it with anyone. Ideally, it should be stored offline, so no unwanted program can access it.

## Bitcoin addresses and keys
A public 'Master' key in Bitcoin is a key cryptographically derived from a Bitcoin private key and used to generate Bitcoin addresses to which Bitcoin can be sent.

An unlimited number of Bitcoin addresses can be generated from a single public 'Master' key. While the private key is used to authorize Bitcoin transactions and must therefore be kept private, the Bitcoin addresses derived from a public key can be shared to receive payments.

Public 'Master' keys consist of a long sequence of numbers and letters and begin with xpub, ypub, or zpub. A Bitcoin address for receiving payments begins with either 1, 3, or bc1.

## Mining
When a user wants to send a transaction on the Bitcoin network, they must sign the transaction with their private key to prove that they own the funds being transferred. Once the transaction is signed, it's broadcast to the peer-to-peer network.

Mining is the process of adding transactions to the Bitcoin blockchain. When a transaction is broadcast to the network, it's picked up by miners who verify that the transaction is valid (i.e. the user has the necessary funds, and the private key used to sign the transaction corresponds to the public key associated with the funds).

Once a transaction is verified, it's added to a block of transactions along with a mathematical puzzle. Miners compete to solve the puzzle, and the first to solve it gets to add the block to the blockchain and claim a reward in bitcoin. The reward is currently 6.25 bitcoin, plus any transaction fees that were included in the block.

In addition to adding transactions to the blockchain, mining activities contribute to the security of the Bitcoin network. This is because solving the puzzle requires significant computing power, and adding a block to the blockchain requires other miners to verify the solution. All of this makes it very difficult for a single person or group to manipulate Bitcoin's blockchain.

## Proof of Work (PoW)
Decentralized systems by definition don't have a single source of truth.

Satoshi's breakthrough was to build a system that allows all participants to independently arrive at the same truth. Proof of work is what makes this possible. The point of proof of work is to create an indisputable history. If two histories compete, the one with the most work embedded in it wins.

The chain with the most work is the truth, by definition. This is called Nakamoto consensus. It works because work requires energy. In Bitcoin, the work consists of computations. Not just any computations, but ones that have no shortcut: guessing.

In the absence of a central authority, proof of work is necessary because it ensures there's no shortcut to adding transactions to the blockchain.

Miners have to compete to solve the puzzle through brute-force computation, which is probabilistic in nature, and the proof that the work has been done becomes evident as the result of the work performed. This makes it very difficult for a single person or group to manipulate the transaction history.

## The difficulty adjustment
A crucial element of the Bitcoin protocol is the difficulty adjustment. This algorithm ensures that new blocks are found roughly every 10 minutes on average.

When more miners join the network, the average time required to find a new block decreases. Conversely, when miners leave the network, it takes longer to add a new block. The difficulty adjustment algorithm adjusts the difficulty of the mathematical puzzle to match changes in the total computing power of all miners. This prevents the creation of more (or fewer) bitcoin units than the fixed 21 million.

This stands in stark contrast to physical mining for precious metals like gold, where adding more gold miners leads to a higher supply of gold and therefore a price decline. In Bitcoin, however, adding new miners only contributes more security to the network.
