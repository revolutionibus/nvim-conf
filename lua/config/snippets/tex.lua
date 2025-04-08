local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

-- Enable autosnippets
ls.config.setup({
  enable_autosnippets = true,
--  history = true,
  update_events = "TextChanged,TextChangedI",
})




-- Greek letter mappings
local greek_map = {
  a = 'alpha',
  b = 'beta',
  g = 'gamma',
  d = 'delta',
  e = 'epsilon',
  z = 'zeta',
  h = 'eta',
  q = 'theta',
  i = 'iota',
  k = 'kappa',
  l = 'lambda',
  m = 'mu',
  n = 'nu',
  x = 'xi',
  o = 'omicron',
  p = 'pi',
  r = 'rho',
  s = 'sigma',
  t = 'tau',
  u = 'upsilon',
  f = 'phi',
  c = 'chi',
  y = 'psi',
  w = 'omega',
}

local greek_snippets = {}
for key, name in pairs(greek_map) do
  table.insert(greek_snippets, s({ trig = ';' .. key, wordTrig = false }, { t('\\' .. name) }))
end

ls.add_snippets('tex', greek_snippets, { key = 'autosnippets' },{condition= is_math})

-- Common environments
local tex_snippets = {
  -- Inline math environment
  s({ trig = 'mk', wordTrig = false }, {
    t('$'),
    i(1),
    t('$'),
  }),
 
  s({ trig = 'int', wordTrig = false }, {
    t('\\int_{'),
    i(1),
    t('}^{'),
    i(2),
    t('}'),
    i(0),
  }),
  -- Equation environment
  s({ trig = 'eq', wordTrig = false }, {
    t('\\begin{equation}'),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{equation}' }),
  }),
  
  -- Align environment
  s({ trig = 'al', wordTrig = false }, {
    t('\\begin{align}'),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{align}' }),
  }),
  
  -- Itemize environment
  s({ trig = 'it', wordTrig = false }, {
    t('\\begin{itemize}'),
    t({ '', '\\item ' }),
    i(1),
    t({ '', '\\end{itemize}' }),
  }),
  
  -- Enumerate environment
  s({ trig = 'en', wordTrig = false }, {
    t('\\begin{enumerate}'),
    t({ '', '\\item ' }),
    i(1),
    t({ '', '\\end{enumerate}' }),
  }),
  
  -- Figure environment
  s({ trig = 'fig', wordTrig = false }, {
    t('\\begin{figure}[h]'),
    t({ '', '\\centering' }),
    t({ '', '\\includegraphics[width=' }),
    i(1, '0.8\\textwidth'),
    t({ ']{' }),
    i(2, 'path/to/image'),
    t({ '}' }),
    t({ '', '\\caption{' }),
    i(3, 'Caption'),
    t({ '}' }),
    t({ '', '\\label{fig:' }),
    i(4, 'label'),
    t({ '}' }),
    t({ '', '\\end{figure}' }),
  }),
  
  -- Table environment
  s({ trig = 'tab', wordTrig = false }, {
    t('\\begin{table}[h]'),
    t({ '', '\\centering' }),
    t({ '', '\\begin{tabular}{' }),
    i(1, 'c|c|c'),
    t({ '}' }),
    t({ '', '\\hline' }),
    i(2),
    t({ '', '\\hline' }),
    t({ '', '\\end{tabular}' }),
    t({ '', '\\caption{' }),
    i(3, 'Caption'),
    t({ '}' }),
    t({ '', '\\label{tab:' }),
    i(4, 'label'),
    t({ '}' }),
    t({ '', '\\end{table}' }),
  }),
  
  -- Section
  s({ trig = 'sec', wordTrig = false }, {
    t('\\section{' ),
    i(1, 'Section Title'),
    t({ '}', '' }),
    i(0),
  }),
  
  -- Subsection
  s({ trig = 'sub', wordTrig = false }, {
    t('\\subsection{' ),
    i(1, 'Subsection Title'),
    t({ '}', '' }),
    i(0),
  }),
  
  -- Math mode display
  s({ trig = 'dm', wordTrig = false }, {
    t('\\['),
    i(1),
    t('\\]'),
  }),
  
  -- Bold text
  s({ trig = 'bf', wordTrig = false }, {
    t('\\textbf{' ),
    i(1),
    t('}'),
  }),
  
  -- Italic text
  s({ trig = 'it', wordTrig = false }, {
    t('\\textit{' ),
    i(1),
    t('}'),
  }),
  
  -- Citation
  s({ trig = 'cite', wordTrig = false }, {
    t('\\cite{' ),
    i(1),
    t('}'),
  }),
  
  -- Reference
  s({ trig = 'ref', wordTrig = false }, {
    t('\\ref{' ),
    i(1),
    t('}'),
  }),
  
  -- Label
  s({ trig = 'lab', wordTrig = false }, {
    t('\\label{' ),
    i(1),
    t('}'),
  }),
  
  -- Fraction
  s({ trig = 'frac', wordTrig = false }, {
    t('\\frac{' ),
    i(1),
    t('}{' ),
    i(2),
    t('}'),
  }),
  
  -- Matrix
  s({ trig = 'mat', wordTrig = false }, {
    t('\\begin{pmatrix}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{pmatrix}' }),
  }),
  
  -- Cases environment
  s({ trig = 'case', wordTrig = false }, {
    t('\\begin{cases}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{cases}' }),
  }),
  
  -- Theorem environment
  s({ trig = 'thm', wordTrig = false }, {
    t('\\begin{theorem}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{theorem}' }),
  }),
  
  -- Proof environment
  s({ trig = 'pf', wordTrig = false }, {
    t('\\begin{proof}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{proof}' }),
  }),
  
  -- Definition environment
  s({ trig = 'def', wordTrig = false }, {
    t('\\begin{definition}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{definition}' }),
  }),
  
  -- Example environment
  s({ trig = 'ex', wordTrig = false }, {
    t('\\begin{example}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{example}' }),
  }),
  
  -- Remark environment
  s({ trig = 'rem', wordTrig = false }, {
    t('\\begin{remark}' ),
    t({ '', '' }),
    i(1),
    t({ '', '\\end{remark}' }),
  }),
}

-- Register all snippets
ls.add_snippets('tex', tex_snippets)

-- Add the existing preamble snippet
ls.add_snippets('tex', {
  s({ trig = 'preamble', wordTrig = false }, {
    t {
      '\\documentclass{article}',
      '\\usepackage[utf8]{inputenc}',
      '\\usepackage{amsmath, amssymb}',
      '\\usepackage{graphicx}',
      '\\usepackage{hyperref}',
      '',
      '\\title{Notes}',
      '\\author{Your Name}',
      '\\date{\\today}',
      '',
      '\\begin{document}',
      '\\maketitle',
      '',
      '',
      '\\end{document}',
    },
  }),
})
