" Vim filetype plugin file
" Language:	haskell

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
autocmd BufEnter *.hs call s:setup_ghc_options()

let maplocalleader='_'
map <buffer> <LocalLeader>t :GhcModType<Return>
map <buffer> <LocalLeader>T :GhcModTypeInsert<Return>
map <buffer> <LocalLeader>i :GhcModInfo<Return>

setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

function! s:setup_ghc_options()
  " Add '-nocode' for performance
  let g:ghcmod_ghc_options = ['-nocode']
  " Setup src and test directories
  let src_dir = finddir('src', '.;')
  if !empty(src_dir)
    let g:ghcmod_use_basedir = fnamemodify(src_dir . '/..', ':p')
    call add(g:ghcmod_ghc_options, '-i' . fnamemodify(src_dir, ':p'))
  endif
  let test_dir = finddir('test', '.;')
  if !empty(test_dir)
    call add(g:ghcmod_ghc_options, '-i' . fnamemodify(test_dir, ':p'))
  endif
  let dist_dir = finddir('dist', '.;')
  if !empty(dist_dir)
    call add(g:ghcmod_ghc_options, '-i' . fnamemodify(dist_dir, ':p') . 'build/autogen/')
  endif
  " Setup package configuration folder
  let ghc_dir = finddir('.ghc', '.;')
  if !empty(ghc_dir)
    call add(g:ghcmod_ghc_options, '-package-conf=' . expand(fnamemodify(ghc_dir, ':p') . '**/package.conf.d/'))
  endif
  let cabal_dev_dir = finddir('cabal-dev', '.;')
  if !empty(cabal_dev_dir)
    " Setup cabal_dev package configuration folder
    let cabal_dev_packages_dir = expand(fnamemodify(sort(split(globpath(cabal_dev_dir, 'packages-*.conf'), '\n'))[-1], ':p'))
    call add(g:ghcmod_ghc_options, '-package-conf=' . cabal_dev_packages_dir)
    " Force individual cabal packages
    let cabal_dev_packages = split(globpath(cabal_dev_packages_dir, '*.conf'), '\n')
    for package_conf in cabal_dev_packages
      let package = fnamemodify(package_conf, ':t')[:-6] " Remove '.conf'
      call add(g:ghcmod_ghc_options, '-package-id=' . package)
    endfor
  endif
endfunction
