module oyster2::oyster_game {
    use sui::random::{Self, Random};
    use sui::event;
    use sui::balance::{Self, Balance};
    use std::string::String;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// Represents an Oyster in the game
    public struct Oyster has key, store {
        id: UID,
        rarity: u8,
        birth_time: u64,  // This will now be set automatically
        pearl_ready: bool,
        url: String,
    }

    /// Event to log the hatching of a new Oyster
    public struct OysterHatchedEvent has copy, drop {
        rarity: u8,
        birth_time: u64,
        url: String,
    }

    /// Function to hatch a new Oyster NFT with randomized attributes
    entry fun hatch_oyster(
        r: &Random,
        url: String,
        ctx: &mut TxContext
    ) {
        let mut generator = random::new_generator(r, ctx);
        let rarity = random::generate_u8_in_range(&mut generator, 1, 5);
        
        // Get timestamp from transaction context
        let birth_time = tx_context::epoch_timestamp_ms(ctx);

        let oyster = Oyster {
            id: object::new(ctx),
            rarity,
            birth_time,   // Using the transaction timestamp
            pearl_ready: false,
            url,
        };

        event::emit(OysterHatchedEvent { 
            rarity, 
            birth_time,
            url 
        });

        transfer::transfer(oyster, tx_context::sender(ctx));
    }
}