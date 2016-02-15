if exists('g:loaded_ctrlp_env') && g:loaded_ctrlp_env
    finish
endif
let g:loaded_ctrlp_env = 1

call add(g:ctrlp_ext_vars, {
    \ 'init': 'ctrlp#env#init()',
    \ 'exit': 'ctrlp#env#exit()',
    \ 'accept': 'ctrlp#env#accept',
    \ 'lname': 'env',
    \ 'sname': 'env',
    \ 'type': 'dir',
    \ 'sort': 0,
    \ })

function! ctrlp#env#init()
    let l:env = system(s:env_command())
    return split(l:env, '\r\n\|\n')
endfunction

function! ctrlp#env#exit()
endfunction

function! ctrlp#env#accept(mode, str)
    call ctrlp#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#env#id()
    return s:id
endfunction

function! s:env_command()
    if has("win16") || has("win32") || has("win64")
        return "set"
    else
        return "printenv"
    endif
endfunction
