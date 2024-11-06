/// Module: roll_dice
module open_oyster::open_oyster{
    use sui::random::{Self, Random};
    use sui::event;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct Dice has key, store {
        id: UID,
        value: u8,
    }
    public struct DiceEvent has copy, drop {
        value: u8
    }

    // 生成一个1到6的随机数
    entry fun roll_dice(
        r: &Random,
        ctx: &mut TxContext
    ): u8 {
        let mut generator = random::new_generator(r,ctx);
        let result = random::generate_u8_in_range(&mut generator, 1, 6);
        result
    }

    entry fun try_luck(
        r: &Random,
        ctx: &mut TxContext
    ) {
        let mut generator = random::new_generator(r, ctx);
        let value = random::generate_u8_in_range(&mut generator, 1, 6);
        
        // Only mint NFT if value is 6
        if (value == 6) {
            let dice = Dice {
                id: object::new(ctx),
                value,
            };

            // emit event
            event::emit(DiceEvent{value});
            //transfer
            transfer::transfer(dice, tx_context::sender(ctx));
        } else {
            // Optional: emit event to show what number was rolled
            event::emit(DiceEvent{value});
        };
    }

}
