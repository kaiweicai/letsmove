module task04::finger_guessing_game{
    use sui::clock::{Self,Clock};
    use std::debug;

    const ROCK:u8=1;
    const SCISSORS:u8=2;
    const PAPER:u8=3;
    const ERR_INVLIDAT_GESTURE:u64 = 1;


    public struct GameOutcome has drop,copy{
        player_gesture:u8,
        ai_gesture:u8,
        out_come:u64,
    }

    public entry fun play(user_gesture:u8,clock:&Clock){
        assert!(user_gesture == ROCK|| user_gesture == SCISSORS ||  user_gesture == PAPER,ERR_INVLIDAT_GESTURE);
        let mechine_gester = generate_random_gesture(clock);
    }

    fun generate_random_gesture(clock:&Clock):u8{
        let timestamp = clock::timestamp_ms(clock);
        let random_value = timestamp%3;
        debug::print(&random_value);
        random_value as u8
    }

    fun is_plaer_win(player_gesture:u8,mechine_gesture:u8)

}

#[test_only]
module task04::game_tests{

    use sui::test_scenario as ts;


    #[test, expected_failure(abort_code = task04::finger_guessing_game::ERR_INVLIDAT_GESTURE)]
    fun test_err_play(){
        let addr1 = @0xA;
        let addr2 = @0xB;
        // create the NFT
        let mut scenario = ts::begin(addr1);
        {
            let clock = 0x8::clock::Clock{};
            task04::finger_guessing_game::play(5u8,&clock);
            abort 0
        }
        ts::next_tx(scenario,addr1);{

        }
    }
}