" vim-linux-coding-style/autoload/vim_linux_coding_style.vim: helper functions
" for vim-linux-coding-style.
" By Christopher White <cxwembedded@gmail.com>, github.com/cxw42
" Copyright (c) 2019 D3 Engineering, LLC.  
" Distributed under the same terms as Vim itself.

let s:save_cpo = &cpo
set cpo&vim

" Create a kernel-doc block for a function
function! vim_linux_coding_style#KernelDocFunction()
    exe "norm! 0iVLCS___MARKER"
    exe "norm! f("
    " Make the header
    exe "norm! yBO/**\<c-m> * \<c-r>\"() - TODO.\<c-m> */"

    " Go back to the marker
    let l:marker_pos = search('VLCS___MARKER', 'cW')
    if l:marker_pos == 0
        return
    endif

    " Delete the marker
    exe "norm! 13x"     

    " Grab the parameters
    exe "norm! f(a\<c-g>u\<Esc>v%Jlyi)u"
        " a\<c-g>u\<Esc> breaks the Undo sequence so that the u will
        " only undo the J.  See |i_CTRL-G_u| and |:undojoin|.
        " Unfortunately, this does break undo of this function into two
        " parts, and I can't figure out how to join them.

    " Paste them in
    exe "norm! kO* \<c-r>\""

    " Format them.  TODO.

endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" === Some testcases ===

"void foo()

"void bar(int param)

"void bat(int param, int other)

"void baz(int param,
"int other,
"int third)

" vim: ts=4 et sw=4
