# global hot-key
function custom_git_print_lg_and_status{
  echo ============================================================
  echo ============================================================
  git st 
  echo ----------------------------------------
  echo ----------------------------------------
  git lg
}
# Set-Alias g custom_git_print_lg_and_status
Set-Alias g lazygit
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias v nvim

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward

# Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\zash.omp.json" | Invoke-Expression
