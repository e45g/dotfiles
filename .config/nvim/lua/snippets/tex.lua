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
}
