Vim Runfile
-----------

Press F5 to execute the current file in whatever language it is written in.

Setup:
1. Add the code inside `.vimrc` to your `.vimrc`.
2. Place `.vim_lang_map` and `.vim_translator_map` in `~/.config/vim/runfile/`.
3. Edit those files to map extensions to languages and languages to commands. `%` in commands is replaced with the file path.

Examples:
- lang_map: `py=python3`
- translator_map: `python3=python3 %`
