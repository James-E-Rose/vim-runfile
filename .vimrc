" The F5 key is used to execute the current file using whatever translator is desired

" Change both maps according to their actual location in your system
let g:lang_map = expand('~/.config/vim/runfile/.vim_lang_map')
let g:translator_map = expand('~/.config/vim/runfile/.vim_translator_map')

" Used for automatic detection of the language from the file extension using .vim_lang_map
function! DetectLang()
	let l:extension = expand('%:e')
	let l:lang_lines = readfile(g:lang_map)
	for l:line in l:lang_lines
		let l:line = substitute(l:line, '\s*".*$', '', '')
		if l:line =~ '^' . l:extension . '='
			return substitute(l:line, '^' . l:extension . '=', '', '')
		endif
	endfor

	return ''
endfunction

" Used to execute the file from the language using .vim_translator_map
function! Execute(lang)
	let l:translator_lines = readfile(g:translator_map)
	for l:line in l:translator_lines
		let l:line = substitute(l:line, '\s*".*$', '', '')
		if l:line =~ '^' . a:lang . '='
			let l:cmd = substitute(l:line, '^' . a:lang . '=', '', '')
			let l:cmd = substitute(l:cmd, '%', shellescape(expand('%:p')), 'g')
			call term_start(['/bin/sh', '-c', l:cmd])
			return 0
		endif
	endfor
	return 1
endfunction

function! RunFile()
	let l:lang = DetectLang()
	" Ensure the correct language is used
	if l:lang != ''
		let l:change_lang = input(l:lang . ' detected. If this is correct, just press enter. Enter language: ')
		if l:change_lang != ''
			let l:lang = l:change_lang
		endif
	else
		let l:lang = input('No known file extension detected. Enter language: ')
	endif

	let l:execute_failure = Execute(l:lang)
	if l:execute_failure
		echom 'Execution failure. ' . l:lang . ' not found in ' . g:translator_map
	endif
endfunction

nnoremap <F5> :call RunFile()<CR>

