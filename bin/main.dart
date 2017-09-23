// Copyright (c) 2017, rreed. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
//
// Be careful to use the right documentation for Crypto:
// https://www.dartdocs.org/documentation/crypto/2.0.2/crypto/crypto-library.html
//
import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';

main() {
  //Block genesisBlock = new Block(sha256.convert([0]), genesisTransactions);
  //String block2Transactions = ":ivan sent satoshi 10 bitcoin" + ":satoshi sent 10 bitcoin to starbucks";
  //Block block2 = new Block(genesisBlock.getBlockHash(), block2Transactions);

  //print("Hash of genesis block: ${genesisBlock.getBlockHash()}");
  //print("Hash of block 2: ${block2.getBlockHash()}");

  List<Block> blockChain = new List<Block>();

  Block block = new Block(new Digest([]), ""); // genesis block
  blockChain.add(block);

  for (int blkCtr = 0; blkCtr < 5; blkCtr++) {
    String transactions = "satoshi>ivan=${(1 + blkCtr) * 10};" + "hal>ivan=${1 + blkCtr};";
    block = new Block(block.getThisBlockHash(), transactions);
    blockChain.add(block);
    print("${block.getPreviousBlockHash()}:${block.getThisBlockHash()} : ${block.getTransactions()}");
  }
}

///
/// A Block is composed of three things: the hash (Digest) of the previous block,
/// the current transactions, and the hash (Digest) of those two.
class Block {
  Digest previousBlockHash;
  String transactions;
  Digest thisBlockHash;

  //Block(Digest previousBlockHash, String transactions) {
  Block(this.previousBlockHash, this.transactions) {
    //this.previousBlockHash = previousBlockHash;
    //this.transactions = transactions;
    //
    // Convert the previousBlockHash to hex digits, and then cat
    // it with the transactions, and then get the hash of that for
    // the hash of this block.
    //
    String hexDigitsForPreviousBlockHash = previousBlockHash.toString();
    String contents = hexDigitsForPreviousBlockHash + " : " + transactions;
    List<int> transactionsAsIntList = contents.runes.toList(growable:false);
    thisBlockHash = sha256.convert(transactionsAsIntList);
  }

  mine() {
    // Find a nonce that will satisfy the difficulty requirement
  }

  // make these getters and setters so can do block.previousBlockHash
  Digest getPreviousBlockHash() {
    return previousBlockHash;
  }

  String getTransactions() {
    return transactions;
  }

  Digest getThisBlockHash() {
    return thisBlockHash;
  }
}
//final _usage = 'Usage: dart hash.dart <md5|sha1|sha256> <input_filename>';
//
//Future main(List<String> args) async {
//  if (args == null || args.length != 2) {
//    print(_usage);
//    exit(1);
//  }
//
//  Hash hasher;
//
//  switch (args[0]) {
//    case 'md5':
//      hasher = md5;
//      break;
//    case 'sha1':
//      hasher = sha1;
//      break;
//    case 'sha256':
//      hasher = sha256;
//      break;
//    default:
//      print(_usage);
//      exit(1);
//  }
//
//  var filename = args[1];
//  var inputFile = new File(filename);
//
//  if (!inputFile.existsSync()) {
//    print('File "$filename" does not exist.');
//    exit(1);
//  }
//
//  Stream<List<int>> inputFileStreamListInts = inputFile.openRead();
//  var value = await hasher.bind(inputFileStreamListInts).first;
//  print(value);
//
//  List<int> someNumbers = [1,2,3,4,5,6,7,8];
//  var hashedNumbers = await hasher.convert(someNumbers);
//  print(hashedNumbers);
//}