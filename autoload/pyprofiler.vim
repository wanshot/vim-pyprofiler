" version: 0.9.0
" author : wan <one_kkm@icloud.com>
" license: mit license
let s:save_cpo = &cpo
set cpo&vim



function! pyprofiler#pypro()
    if expand("%:e") == "py"
        let s:script_path = expand('%:p')
        let s:script_name = expand('%:t')
        botright new __PyProfiler__
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
        silent execute 'r !python -m kernprof -l -v ' . s:script_path
"        setlocal nomodifiable
        nnoremap <script> <silent> <buffer> q             :call <sid>PyprofilerClose()<CR>
        cabbrev  <script> <silent> <buffer> q             call <sid>PyprofilerClose()
    else
        echo "Not Python File"
    endif
endfunction

function! s:PyprofilerBufferName(name)
    if bufwinnr(bufnr(a:name)) != -1
        exe bufwinnr(bufnr(a:name)) . "wincmd w"
        return 1
    else
        return 0
    endif
endfunction

function! s:PyprofilerClose()
    if s:PyprofilerBufferName('__PyProfiler__')
        quit
        let cwd = getcwd()
        if has('unix') || has('mac')
            let s:deletefile = cwd . '/' . s:script_name . '.lprof'
        endif
        if has('win32') || has ('win64')
            let s:deletefile = cwd . '\\' . s:script_name . '.lprof'
        endif
        call delete(s:deletefile)
    endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
