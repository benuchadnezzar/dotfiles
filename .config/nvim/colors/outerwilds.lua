-- Outer Wilds colorscheme for Neovim
-- Palette inspired by: Timber Hearth campfires, the Sun Station,
-- Nomai ruins, Brittle Hollow ice, Dark Bramble, and the supernova.
--
-- Install: save as ~/.config/nvim/colors/outerwilds.lua
-- Use:     :colorscheme outerwilds

local M = {}

M.palette = {
  bg          = "#0d0e1a", -- deep space
  bg_alt      = "#15172a", -- panels / floats
  bg_highlight= "#1c1f38", -- cursorline / visual
  bg_lighter  = "#242847", -- subtle UI borders

  fg          = "#e8dcc8", -- warm parchment (Nomai text glow)
  fg_dim      = "#a7a8bd", -- muted foreground
  comment     = "#5c6178", -- slate blue, dim

  orange      = "#e8823c", -- campfire / marshmallow
  orange_dim  = "#c76a2e",
  red         = "#e8563e", -- supernova / lava
  red_dim     = "#c23f2c",
  gold        = "#d9a441", -- Timber Hearth soil, Hourglass sand
  green       = "#5fb98c", -- Giant's Deep islands
  cyan        = "#5ec9c9", -- Quantum Moon, probe
  blue        = "#6ab0f3", -- Brittle Hollow ice
  purple      = "#a78bd9", -- Nomai text, Dark Bramble
  purple_dim  = "#8b6bd6",

  error       = "#e8563e",
  warn        = "#d9a441",
  info        = "#6ab0f3",
  hint        = "#5fb98c",
}

function M.setup()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "outerwilds"

  local p = M.palette
  local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

  -- Editor UI
  hl("Normal",       { fg = p.fg, bg = p.bg })
  hl("NormalFloat",  { fg = p.fg, bg = p.bg_alt })
  hl("FloatBorder",  { fg = p.purple_dim, bg = p.bg_alt })
  hl("Cursor",       { fg = p.bg, bg = p.orange })
  hl("CursorLine",   { bg = p.bg_highlight })
  hl("CursorLineNr", { fg = p.orange, bold = true })
  hl("LineNr",       { fg = p.comment })
  hl("SignColumn",   { bg = p.bg })
  hl("ColorColumn",  { bg = p.bg_highlight })
  hl("VertSplit",    { fg = p.bg_lighter })
  hl("WinSeparator", { fg = p.bg_lighter })
  hl("Visual",       { bg = p.bg_lighter })
  hl("Search",       { fg = p.bg, bg = p.gold })
  hl("IncSearch",    { fg = p.bg, bg = p.orange })
  hl("Pmenu",        { fg = p.fg, bg = p.bg_alt })
  hl("PmenuSel",     { fg = p.bg, bg = p.purple })
  hl("PmenuSbar",    { bg = p.bg_lighter })
  hl("PmenuThumb",   { bg = p.purple_dim })
  hl("StatusLine",   { fg = p.fg, bg = p.bg_alt })
  hl("StatusLineNC", { fg = p.comment, bg = p.bg_alt })
  hl("TabLine",      { fg = p.comment, bg = p.bg_alt })
  hl("TabLineSel",   { fg = p.orange, bg = p.bg })
  hl("Directory",    { fg = p.blue })
  hl("Title",        { fg = p.orange, bold = true })
  hl("MatchParen",   { fg = p.orange, bold = true, underline = true })
  hl("NonText",      { fg = p.bg_lighter })
  hl("Whitespace",   { fg = p.bg_lighter })
  hl("Folded",       { fg = p.comment, bg = p.bg_alt })

  -- Diagnostics
  hl("DiagnosticError", { fg = p.error })
  hl("DiagnosticWarn",  { fg = p.warn })
  hl("DiagnosticInfo",  { fg = p.info })
  hl("DiagnosticHint",  { fg = p.hint })
  hl("DiagnosticUnderlineError", { undercurl = true, sp = p.error })
  hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.warn })

  -- Diff / git
  hl("DiffAdd",    { fg = p.green, bg = p.bg_alt })
  hl("DiffChange", { fg = p.gold, bg = p.bg_alt })
  hl("DiffDelete", { fg = p.red, bg = p.bg_alt })
  hl("DiffText",   { fg = p.blue, bg = p.bg_alt })
  hl("GitSignsAdd",    { fg = p.green })
  hl("GitSignsChange", { fg = p.gold })
  hl("GitSignsDelete", { fg = p.red })

  -- Syntax
  hl("Comment",        { fg = p.comment, italic = true })
  hl("Constant",       { fg = p.gold })
  hl("String",         { fg = p.green })
  hl("Character",      { fg = p.green })
  hl("Number",         { fg = p.orange })
  hl("Boolean",        { fg = p.orange, bold = true })
  hl("Float",          { fg = p.orange })
  hl("Identifier",     { fg = p.fg })
  hl("Function",       { fg = p.blue, bold = true })
  hl("Statement",      { fg = p.purple, bold = true })
  hl("Conditional",    { fg = p.purple })
  hl("Repeat",         { fg = p.purple })
  hl("Label",          { fg = p.purple })
  hl("Operator",       { fg = p.orange_dim })
  hl("Keyword",        { fg = p.purple, bold = true })
  hl("Exception",      { fg = p.red })
  hl("PreProc",        { fg = p.cyan })
  hl("Include",        { fg = p.cyan })
  hl("Define",         { fg = p.cyan })
  hl("Macro",          { fg = p.cyan })
  hl("Type",           { fg = p.cyan, bold = true })
  hl("StorageClass",   { fg = p.cyan })
  hl("Structure",      { fg = p.cyan })
  hl("Typedef",        { fg = p.cyan })
  hl("Special",        { fg = p.orange })
  hl("SpecialChar",    { fg = p.orange })
  hl("Tag",            { fg = p.purple })
  hl("Delimiter",      { fg = p.fg_dim })
  hl("SpecialComment", { fg = p.comment, bold = true })
  hl("Underlined",     { underline = true, fg = p.blue })
  hl("Error",          { fg = p.error, bold = true })
  hl("Todo",           { fg = p.bg, bg = p.gold, bold = true })

  -- Treesitter (common groups)
  hl("@variable",         { fg = p.fg })
  hl("@variable.builtin", { fg = p.red, italic = true })
  hl("@parameter",        { fg = p.fg_dim, italic = true })
  hl("@field",             { fg = p.blue })
  hl("@property",          { fg = p.blue })
  hl("@constructor",       { fg = p.cyan })
  hl("@punctuation.bracket",  { fg = p.fg_dim })
  hl("@punctuation.delimiter", { fg = p.fg_dim })
  hl("@keyword.function",  { fg = p.purple, bold = true })
  hl("@keyword.return",    { fg = p.purple, bold = true })
  hl("@string.escape",     { fg = p.orange })
  hl("@tag.attribute",     { fg = p.gold, italic = true })

  -- Telescope / picker style plugins
  hl("TelescopeBorder",  { fg = p.purple_dim })
  hl("TelescopeSelection", { bg = p.bg_lighter, fg = p.orange })
  hl("TelescopeMatching", { fg = p.gold, bold = true })
end

M.setup()

return M
