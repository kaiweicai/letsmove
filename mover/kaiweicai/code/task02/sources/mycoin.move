module task02::mycoin {
    use sui::coin::{Self, TreasuryCap,Coin};

    public struct MYCOIN has drop {}

    fun init(otw: MYCOIN, ctx: &mut sui::tx_context::TxContext) {
        let (treasury_cap, meta) = coin::create_currency(otw, 8, b"KAIWEICAI", b"KAIWEICAI", b"kaiweicai token", option::none(), ctx);
        transfer::public_freeze_object(meta);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<MYCOIN>, 
        amount: u64, 
        recipient: address, 
        ctx: &mut TxContext,
    ) {
        coin::mint_and_transfer(treasury_cap,amount,recipient,ctx)
    }

    public fun burn(treasure_cap:&mut TreasuryCap<MYCOIN>,coin:Coin<MYCOIN>){
        coin::burn(treasure_cap,coin);
    }

    #[test_only]
    /// Wrapper of module initializer for testing
    public fun test_init(ctx:&mut TxContext){
        init(MYCOIN{},ctx)
    }
}
