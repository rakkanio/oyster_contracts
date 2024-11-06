
/// Module: roll_dice
module roll_dice::roll_dice{
    use sui::random::{Self, Random};
    use sui::event;

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

    entry fun roll_dice_mint_nft(
        r: &Random,
        ctx: &mut TxContext
    ) {
        let value = roll_dice(r, ctx);
        let dice = Dice{
            id: object::new(ctx),
            value,
        };

        // emit event
        event::emit(DiceEvent{value});
        //transfer
        transfer::transfer(dice, tx_context::sender(ctx));
    }

}
