" Copy yanked text to the OS clipboard.
" Use `tmux` when available, otherwise send OSC 52 directly to the terminal.
function! CopyToClipboard() abort
    if v:event.operator !=# 'y'
        return
    endif

    let l:register = v:event.regname ==# '' ? '"' : v:event.regname
    let l:text = getreg(l:register)

    if !empty($TMUX)
        call system('tmux load-buffer -w -', l:text)
    else
        let l:encoded = system('base64 | tr -d "\n"', l:text)
        call writefile(["\x1b]52;c;" . l:encoded . "\x07"], '/dev/tty', 'b')
    endif
endfunction

augroup ClipboardIntegration
    autocmd!
    autocmd TextYankPost * call CopyToClipboard()
augroup END
