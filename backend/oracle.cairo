%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.pow import pow

# Oracle Interface Definition

const EMPIRIC_ORACLE_ADDRESS = 0x012fadd18ec1a23a160cc46981400160fbf4a7a5eed156c4669e39807265bcd4
const ETH_KEY = 28556963469423460  # str_to_felt("eth/usd")
const MATIC_KEY = 2017717457628037477220  # str_to_felt("eth/usd")
const BNB_KEY =  27705915699721060 # str_to_felt("eth/usd")
const SOLANA_KEY = 32492132765102948  # str_to_felt("eth/usd")

const AGGREGATION_MODE = 120282243752302  # str_to_felt("median")

@contract_interface
namespace IEmpiricOracle:
    func get_value(key : felt, aggregation_mode : felt) -> (
        value : felt,
        decimals : felt,
        last_updated_timestamp : felt,
        num_sources_aggregated : felt
    ):
    end
end

# Your function
@view
func get_eth{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt):
    alloc_locals

    let (eth_price,
        decimals,
        last_updated_timestamp,
        num_sources_aggregated) = IEmpiricOracle.get_value(
            EMPIRIC_ORACLE_ADDRESS, ETH_KEY, AGGREGATION_MODE
        )
    return (res=eth_price)
end

@view
func get_sol{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt):
    alloc_locals

    let (sol_price,
        decimals,
        last_updated_timestamp,
        num_sources_aggregated) = IEmpiricOracle.get_value(
            EMPIRIC_ORACLE_ADDRESS, SOLANA_KEY, AGGREGATION_MODE
        )
    return (res=sol_price)
end
@view
func get_bnb{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt):
    alloc_locals

    let (bnb_price,
        decimals,
        last_updated_timestamp,
        num_sources_aggregated) = IEmpiricOracle.get_value(
            EMPIRIC_ORACLE_ADDRESS, BNB_KEY, AGGREGATION_MODE
        )
    return (res=bnb_price)
end

@view
func get_matic{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res:felt):
    alloc_locals

    let (matic_price,
        decimals,
        last_updated_timestamp,
        num_sources_aggregated) = IEmpiricOracle.get_value(
            EMPIRIC_ORACLE_ADDRESS, MATIC_KEY, AGGREGATION_MODE
        )
    return (res=matic_price)
end