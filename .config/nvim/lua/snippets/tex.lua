-- File: ~/.config/nvim/lua/snippets/tex.lua
-- Add this to your LuaSnip snippets

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
    -- Document template
    s("template", fmt([[
\documentclass[11pt,a4paper]{{article}}
\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}
\usepackage[czech]{{babel}}
\usepackage[margin=2.5cm]{{geometry}}
\usepackage{{amsmath,amssymb}}
\usepackage{{graphicx}}
\usepackage{{hyperref}}
\usepackage{{enumerate}}

\title{{{} - {}}}
\author{{{}}}
\date{{\today}}

\begin{{document}}
\maketitle

\pagebreak
\tableofcontents
\pagebreak

{}

\end{{document}}
]], {
            i(1, "Subject"),
            i(2, "Topic"),
            i(3, "Author"),
            i(4, "Content")
        })),

    s("doc", fmt([[
\documentclass[12pt, a4paper, openright]{{report}}

\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}
% \usepackage[czech]{{babel}}
\usepackage{{cmap}}

\usepackage[top=2.5cm, bottom=2.5cm, left=3.5cm, right=1.5cm]{{geometry}}
\usepackage{{csquotes}}
\usepackage{{hyperref}}
\usepackage{{xurl}}
\usepackage{{url}}

\usepackage{{graphicx}}
\usepackage{{subcaption}}
\usepackage{{booktabs}}
\usepackage{{svg}}

\linespread{{1.15}}
\usepackage[pagestyles]{{titlesec}}
\titleformat{{\chapter}}[block]
  {{\scshape\bfseries\LARGE}}
  {{\thechapter}}
  {{10pt}}
  {{\vspace{{-22pt}}}}
\titleformat{{\section}}[block]{{\scshape\bfseries\Large}}{{\thesection}}{{10pt}}{{\vspace{{0pt}}}}
\titleformat{{\subsection}}[block]{{\bfseries\large}}{{\thesubsection}}{{10pt}}{{\vspace{{0pt}}}}
\setcounter{{secnumdepth}}{{2}}
\setcounter{{tocdepth}}{{3}}
\usepackage{{enumitem}}

\setlist[description]{{
    font=\normalfont\small\bfseries
}}

\usepackage{{fancyhdr}}
\pagestyle{{fancy}}
\renewcommand{{\headrulewidth}}{{1pt}}

\usepackage{{verbatim}}
\usepackage{{fancyvrb}}
\usepackage{{tcolorbox}}
\tcbuselibrary{{listings,skins,breakable}}

\newtcblisting{{code}}{{
    colback=gray!9,
    colframe=black,
    boxrule=0.25mm,
    sharp corners,
    listing only,
    breakable,
    fontupper=\normalsize\ttfamily, % normal text size + monospaced
    coltext=black,
    listing options={{
        commentstyle=\footnotesize\ttfamily,
        basicstyle=\footnotesize\ttfamily,
        keywordstyle=\footnotesize\ttfamily,
        stringstyle=\footnotesize\ttfamily,
    }},
    text width=\linewidth
}}

\newcommand\mainTitle{{{}}}

\title{{\mainTitle}}
\author{{{}}}
\date{{{}}}

\begin{{document}}

\pagestyle{{empty}}
\pagenumbering{{Roman}}

{{\bfseries
    \begin{{center}}
        \LARGE{{RANDOM}}

        \vspace{{14pt}}
        \large{{
            {}
        }}

        \vspace{{0.3 \textheight}}

        \LARGE{{
            \mainTitle
        }}
        \vspace{{0.24\textheight}}
    \end{{center}}
}}

\clearpage


\tableofcontents

\pagenumbering{{arabic}}
\pagestyle{{fancy}}
\setcounter{{page}}{{1}}
\end{{document}}
]], {
    i(1, "Title"),
    i(2, "Author"),
    i(3, "Date"),
    i(3, "Subtitle"),
        }))
}
