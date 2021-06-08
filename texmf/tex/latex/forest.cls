\ProvidesClass{forest}
\LoadClass{article}

%%%%%%%%%
%OPTIONS%
%%%%%%%%%

% Set booleans

\newif\ifforest\foresttrue

% Declare options

\DeclareOption{shooting}{\forestfalse} % makes it the shooting style -- blue, section symb changes, probsymb changes

\ProcessOptions

%%%%%%%%%%%%
%ESSENTIALS%
%%%%%%%%%%%%

\RequirePackage{asymptote}
\begin{asydef}
size(6cm);
import olympiad;
import cse5;
import geometry;
\end{asydef}

\RequirePackage{tikz}
\RequirePackage{tkz-euclide}
\usetikzlibrary{calc}

\RequirePackage{babel}

\RequirePackage{amssymb,amsthm}
\RequirePackage{mdframed}

\RequirePackage{universal} % custom package created by Dennis Chen

%%%%%%%%
%COLORS%
%%%%%%%%

\RequirePackage{xcolor}

% These colors have their names chosen to explicitly enumerate what feelings they are supposed to evoke.

\definecolor{forest}{HTML}{033c16}
\definecolor{leaf}{HTML}{ccffbb}
\definecolor{tanbark}{HTML}{640f0f}

\definecolor{nblue}{HTML}{002896}
\definecolor{bgblue}{HTML}{d2f0ff}
\definecolor{emred}{HTML}{91000a}

\ifforest

\colorlet{primary}{forest}
\colorlet{alternate}{leaf}
\colorlet{accent}{tanbark}

\else

\colorlet{primary}{nblue}
\colorlet{alternate}{bgblue}
\colorlet{accent}{emred}

\fi

\definecolor{bggray}{HTML}{e6e6e6}

\RequirePackage[letterpaper,top=2cm,bottom=2cm,left=2.5cm,right=2.5cm,includeheadfoot]{geometry} % geometry has to be BEFORE fancyhdr for margins to work!

%%%%%%%%%%%%%%%%%%%
%FONTS AND SYMBOLS%
%%%%%%%%%%%%%%%%%%%

\RequirePackage{newpxtext,newpxmath}
\RequirePackage{fontawesome, pifont}

\ifforest

\newcommand{\secSymb}{\faTree}
\newcommand{\probSymb}{\faLeaf}
\newcommand{\reqSymb}{\faTint}

\else

\newcommand{\secSymb}{\faGlobe}
\RequirePackage{chessBM}

\fi

% itemize symbols
\renewcommand{\labelitemi}{$\blacksquare$}
\renewcommand{\labelitemii}{\ding{70}}
\renewcommand{\labelitemiii}{$\bullet$}

%%%%%
%TOC%
%%%%%

\setcounter{tocdepth}{2}

\RequirePackage[hypertexnames=false]{hyperref}
\hypersetup{
    colorlinks,
    citecolor=black,
    filecolor=black,
    linkcolor=primary,
    urlcolor=primary
}

\usepackage{tocloft}

\renewcommand{\cfttoctitlefont}{\merri\bfseries\LARGE}
\renewcommand{\cftsecfont}{\hypersetup{linkcolor=primary}\notofont\bfseries\large\color{primary}}
\renewcommand{\cftsubsecfont}{\tlffont}

% shorthand for toc; prevent everything from being blue or whatever

\newcommand{\toc}{
{\hypersetup{
	linkcolor=black}
\tableofcontents
\pagebreak}
}

%%%%%%%%%%%%%%%%%%%
%TITLE AND HEADERS%
%%%%%%%%%%%%%%%%%%%

\RequirePackage{etoolbox} % used for patchcmd

\patchcmd{\@maketitle}{\@title}{\merri\color{primary}\bfseries\@title}{}{}
\patchcmd{\@maketitle}{\@author}{\merri\@author}{}{}
\patchcmd{\@maketitle}{\@date}{\merri\color{primary}{\@date}}{}{}

%%%%%%%%%%%%
%SECTIONING%
%%%%%%%%%%%%

\RequirePackage{titlesec}

\titleformat{\section}
{\notofont\Large\bfseries}{{\color{primary}\secSymb\,\thesection}}{0.8em}{}

% subsections
\titleformat{\subsection}
{\sffamily\large\bfseries}{{\color{primary}\thesubsection}}{0.9em}{}

%subsubsections (just in case!)

\titleformat{\subsubsection}
{\sffamily\normalsize\bfseries}{{\color{primary}\thesubsubsection}}{0.9em}{}

%%%%%%%%%%%%%%%%%%%%%%
%PROBLEM ENVIRONMENTS%
%%%%%%%%%%%%%%%%%%%%%%

%usage: \begin{prob}[source]{points}
% problem
% \end{prob}

\RequirePackage{environ}

\NewEnviron{prob}[2][]{
{\parindent=0pt
\robotofont\color{primary}[#2\,\probSymb]\textbf{\if\relax\detokenize{#1}\else\hspace{3pt}(#1)\fi}}\hspace{3.5pt}\BODY
}
[
\vspace{0.2cm}
]

\NewEnviron{req}[2][]{
{\parindent=0pt
\robotofont\color{accent}[#2\,\reqSymb]\textbf{\if\relax\detokenize{#1}\else\hspace{3pt}(#1)\fi}}\hspace{3.5pt}\BODY
}
[
\vspace{0.2cm}
]

\newcommand{\minpt}[1]{Minimum is {\color{primary}[#1\,\probSymb]}. Problems with the\;{\color{accent}\reqSymb}\;symbol are required.
    \vspace{\baselineskip}
}

\newcommand{\psetquote}[2] % BE CAREFUL WITH THIS. must be DIRECTLY after minpt
{
\vspace{-\baselineskip}
\begin{flushright}
\begin{tikzpicture}
\draw (0,0) node [right,text width=8.75cm]{
\begin{mdframed}[linecolor=primary,leftline=true,rightline=false,bottomline=false,topline=false,linewidth=3pt,backgroundcolor=alternate]
{\alegreyafont``#1''}

\vspace{1mm}

\hfill\color{accent}\fell#2
\end{mdframed}
};

\end{tikzpicture}
\end{flushright}
}

%%%%%%%%%
%VISUALS%
%%%%%%%%%

\newcommand{\db}[1]{{\bfseries\color{accent}#1}}
\newcommand{\dbold}[1]{\db{#1}}

\newcommand{\ansbold}[1]{{\color{accent}\mathbf{#1}}}

\newcommand{\problems}{\pagebreak\section{Problems}}

%%%%%%%%%%
%THEOREMS%
%%%%%%%%%%

\newtheoremstyle{dbox}
	{0pt}
	{2pt}
	{}
	{}
	{\color{primary}\cha\bfseries}
	{}
	{\newline}
	{\vspace{1.5pt}\thmname{#1}\thmnumber{ #2}\thmnote{ --- #3}}
	
\newtheoremstyle{proof}
	{0pt}
	{0pt}
	{}
	{}
	{\color{accent}\sffamily\bfseries}
	{:}
	{4pt}
	{\thmname{#1}\thmnote{ #3}}

\newtheoremstyle{walk}
	{0pt}
	{0pt}
	{}
	{}
	{\color{accent}\sffamily\bfseries}
	{:}
	{0pt}
	{\thmname{#1}\thmnote{ #3}}

\newtheoremstyle{remark}
	{0pt}
	{0pt}
	{}
	{}
	{\color{primary}\sffamily\bfseries}
	{:}
	{1.5mm}
	{\thmname{#1}\thmnote{ #3}}
	
\theoremstyle{dbox}

\newmdtheoremenv[% settings
backgroundcolor=alternate,
nobreak=true,
linecolor=primary,
linewidth=0.6pt,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=true,
bottomline=true,
rightline=true,
leftline=true]{theo}{Theorem}[section]

\newmdtheoremenv[% settings
backgroundcolor=bggray,
nobreak=true,
linecolor=primary,
linewidth=2pt,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=false,
bottomline=false,
rightline=false,
leftline=true]{defi}[theo]{Definition}

\newmdtheoremenv[% settings
backgroundcolor=bggray,
nobreak=true,
linecolor=primary,
linewidth=2pt,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=false,
bottomline=false,
rightline=false,
leftline=true]{fact}[theo]{Fact}

\newmdtheoremenv[% settings
nobreak=true,
linecolor=primary,
linewidth=0.6pt,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=true,
bottomline=true,
rightline=true,
leftline=true]{exam}[theo]{Example}

\newmdtheoremenv[% settings
nobreak=true,
linecolor=primary,
linewidth=0.6pt,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=true,
bottomline=true,
rightline=true,
leftline=true]{exer}[theo]{Exercise}

\newmdtheoremenv[% settings
backgroundcolor=alternate,
nobreak=true,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=false,
bottomline=false,
rightline=false,
leftline=false]{lemma}[theo]{Lemma}

\newmdtheoremenv[% settings
backgroundcolor=alternate,
nobreak=true,
innerleftmargin=7pt,
innerrightmargin=7pt,
innertopmargin=7pt,
topline=false,
bottomline=false,
rightline=false,
leftline=false]{corollary}[theo]{Corollary}

\usepackage{pgf}

\theoremstyle{proof}

\newmdtheoremenv[
nobreak=false,
linecolor=accent,
linewidth=1pt,
leftline=true,
rightline=false,
topline=false,
bottomline=false,
innertopmargin=3pt,
innerbottommargin=3.5pt,
innerleftmargin=7pt
]{pro}{Proof}

\def\endpro{\hfill$\blacksquare$}

\newmdtheoremenv[
nobreak=false,
linecolor=accent,
linewidth=1pt,
leftline=true,
rightline=false,
topline=false,
bottomline=false,
innertopmargin=3pt,
innerbottommargin=3.5pt,
innerleftmargin=7pt
]{sol}{Solution}

\theoremstyle{remark}

\newmdtheoremenv[
nobreak=false,
linecolor=primary,
linewidth=1pt,
leftline=true,
rightline=false,
topline=false,
bottomline=false,
innertopmargin=3pt,
innerbottommargin=3.5pt,
innerleftmargin=7pt
]{remark}{Remark}

\theoremstyle{walk}

\newmdtheoremenv[
nobreak=false,
linecolor=accent,
linewidth=1pt,
leftline=true,
rightline=false,
topline=false,
bottomline=false,
innertopmargin=2pt,
innerbottommargin=4pt,
innerleftmargin=7pt
]{walk}{Walkthrough}

\renewcommand{\walk}{{\sffamily\color{accent}\bfseries Walkthrough:~}}