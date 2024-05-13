module hello::hello {
    use std::string::{String,utf8};
    use sui::transfer::{transfer};
    use sui::tx_context::{sender};

    public struct Hello has key,store{
        id:UID,
        say:String,
    }

    fun init(ctx: &mut tx_context::TxContext) {
        let kaiweicai_move = Hello{
            id:object::new(ctx),
            say:utf8(b"kaiweicai"),
        };
        transfer(kaiweicai_move,sender(ctx));
    }
}
