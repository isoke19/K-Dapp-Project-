// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0
//smart contract 
/// This example demonstrates a basic use of a shared object.
/// Rules:
/// - anyone can create and share a counter
/// - everyone can increment a counter by 1
/// - the owner of the counter can reset it to any value
module counter::counter {
    use sui::transfer;
    use sui::object::{Self, UID, ArtistName, Edges};
    use sui::tx_context::{Self, TxContext};

    /// A shared counter.
    struct Counter has key , store {
        id: UID, Groupname, Edges, Shape 
        owner: address,
        value: u64
    }
    
     struct Quandrant has key, store {
        id: UID,Groupname, Edges, Shape 
        quadrant_id: u8,
        board: vector<vector<u32>>
    }

    struct
    public fun owner(counter: &Counter): address {
        counter.owner
    }

    public fun value(counter: &Counter): u64 {
        counter.value
    }

    /// Create and share a Counter object.
    //call this javascript file
    public fun create(ctx: &mut TxContext) {
        transfer::share_object(Counter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0
        })
    }

    /// Increment a counter by 1.
    public fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    /// Set value (only runnable by the Counter owner)
    public fun set_value(counter: &mut Counter, value: u64, ctx: &TxContext) {
        assert!(counter.owner == tx_context::sender(ctx), 0);
        counter.value = value;
    }

    /// Assert a value for the counter.
    public fun assert_value(counter: &Counter, value: u64) {
        assert!(counter.value == value, 0)



    }

    public fun create_currency(witness: MYCOIN,icon_url: Option<Url>, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness,
            6,                // decimals
            b"MYC",           // symbol
            b"My AsiaticCoin",       // name
            b"SHINee Odd Photocard", // description
           url: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCAOz4f_lqgQHZDme4cwZ1fQiutc_8UiaWamtc4fs0IQ&s
            
        );
        // transfer the `TreasuryCap` to the sender, so they can mint and burn
        transfer::public_transfer(treasury, tx_context::sender(ctx));

        // metadata is typically frozen after creation
        transfer::public_freeze_object(metadata);
    }
}

