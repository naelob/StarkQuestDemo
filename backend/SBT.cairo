%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.uint256 import Uint256

from library import SoleBoundToken

@constructor
func constructor{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
}(owner: felt):
    SoleBoundToken.initializer('SoleBoundToken', 'SOLEBOUNDTOKEN', owner)
    return ()
end

@external
func mint{
    syscall_ptr : felt*, 
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(content: felt) -> ():
    assert_only_owner()
    SoleBoundToken.mint(content)
    return ()
end


@external
func burn{
    syscall_ptr : felt*, 
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(token_id: Uint256) -> ():
    assert_only_owner()
    SoleBoundToken.burn(token_id)
    return ()
end

func assert_only_owner{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}():
    let (caller) = get_caller_address()
    let (owner) = SoleBoundToken.owner()
    with_attr error_message("Account: caller is not the owner"):
        assert owner = caller
    end
    return ()
end