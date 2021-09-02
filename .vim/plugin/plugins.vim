" plugins.vim
" plugin settings


" ctrlp
"   activation shortcut
let g:ctrlp_map = '-'
"   ignore VCS and /pack which contains vim plugins
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v([\/]\.(git|hg|svn)|\/pack)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links' }
"   ignore files specified in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" markdown-preview.nvim
"   launch shortcut
nmap <C-m> <Plug>MarkdownPreview

" fzf
"   set layout
"   ATTENTION: bat needs to be configured to use Solarized (dark) theme,
"   otherwise the text in popup will be unreadable
"   1. ''bat --config-file''
"   2. add --theme="Solarized (dark)" in it
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

" vimwiki
let g:vimwiki_list = [
  \  {'path':'~/z/reference/notes/',
  \   'path_html':'~/z/reference/notes-html/',
  \   'custom_wiki2html': '~/bin/vim_zettel_markdown/vim_zettel_markdown',
  \   'auto_export': 1,
  \   'ext':'.md',
  \   'syntax':'markdown'}]
let g:vimwiki_conceallevel = 0
let g:vimwiki_markdown_link_ext = 1

" vim-zettel
function! s:insert_id()
  if exists("g:zettel_current_id")
    return g:zettel_current_id
  else
    return "unnamed"
  endif
endfunction

let g:zettel_options = [{"template" : "zettel.tpl", "disable_front_matter": 1,
  \  "front_matter" : [
      \ [ "id", function("s:insert_id")],
      \ [ "type", "wiki-article" ],
      \ [ "tags", ":untagged:" ]]
  \ }]

let g:zettel_format = "%Y%m%d%H%M%S"
let g:zettel_date_format = "%Y-%m-%dT%H:%M:%S%z"
