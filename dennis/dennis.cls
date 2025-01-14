% names class

\ProvidesClass{dennis}

% Set booleans

\newif\ifmast\mastfalse
\newif\ifbook\bookfalse
\newif\ifhint\hintfalse
\newif\ifdennisasy\dennisasytrue
\newif\ifoldsec\oldsecfalse
\newif\ifcolorinvert

% Declare options

\DeclareOption{mast}{\masttrue} % formatting for MAST Handouts, includes points & logo
\DeclareOption{asyfalse}{\dennisasyfalse}
\DeclareOption{oldsec}{\oldsectrue}
\DeclareOption{invert}{\colorinverttrue}
\DeclareOption{book}{\booktrue\hinttrue\mastfalse\oldsectrue}

\ProcessOptions\relax

% is this a book?

\ifbook
	\LoadClass[openany]{book}
\else
	\LoadClass{article}
\fi

% asy options
\RequirePackage{asymptote}
\ifdennisasy
	\begin{asydef}
		size(6cm);
		import olympiad;
		import cse5;
		import geometry;
	\end{asydef}
\fi

% universal imports

\RequirePackage{universal}

% colors, needed for pts and title

\RequirePackage{xcolor}
\RequirePackage{colorpalette}

\newpalettetheme{main}

\newpalette{main}{normal}
\newpalette{main}{invert}

\addcolortotheme{main}{primary}
\addcolortotheme{main}{alt}
\addcolortotheme{main}{secondary}

\setpalettecolor{main}{normal}{primary}[rgb]{0,0.2,0.4}
\setpalettecolor{main}{normal}{alt}[rgb]{0.57, 0.0, 0.04}
\setpalettecolor{main}{normal}{secondary}[rgb]{0.11, 0.22, 0.73}

\setpalettecolor{main}{invert}{primary}[rgb]{0.57,0.0,0.04}
\setpalettecolor{main}{invert}{alt}[rgb]{0,0.2,0.4}
\setpalettecolor{main}{invert}{secondary}[RGB]{128,0,0}

\ifcolorinvert
	\activepalette{main}{invert}
\else
	\activepalette{main}{normal}
\fi

\definecolor{titlered}{RGB}{128, 0.0, 0.0}

% theorem colors

\definecolor{thmblue}{rgb}{0.88, 0.95, 0.98}
\definecolor{darkblue}{RGB}{36,57,108}

\definecolor{thmgreen}{RGB}{207,241,208}
\definecolor{darkgreen}{RGB}{30,70,30}

\definecolor{thmred}{RGB}{240, 200, 200}
\definecolor{darkred}{RGB}{120, 30, 20}
\colorlet{importantred}{darkred}

\definecolor{proofbrown}{RGB}{100,40,40}
\definecolor{proofbckg}{HTML}{fffdf5}

\definecolor{darkpurple}{RGB}{45,0,90} % dark purple
\definecolor{lightpurple}{RGB}{230,230,250}
\colorlet{dennispurple}{darkpurple}

\definecolor{solcolor}{RGB}{0,25,0}

\definecolor{remcolor}{RGB}{220,220,220}

% Points setup
\RequirePackage{fontawesome}

\newcounter{problem}\setcounter{problem}{0} % Problem number counter

% pls use this in the future

\newenvironment{prob}[2][]
{\parindent=0pt
	\raggedright
	\stepcounter{problem}{\applycolor{main}{primary}[#2\,\faPencil]} \textbf{Problem \theproblem}{\if\relax\detokenize{#1}\relax\else\hspace{3pt}(#1)\fi}\hspace{3.5pt}\ignorespaces
}
{
	\vspace{0.2cm}
}

\newenvironment{req}[2][]
{\parindent=0pt
	\raggedright
	\stepcounter{problem}{\applycolor{main}{primary}[#2\,\faDiamond]} \textbf{{\applycolor{main}{alt}Problem \theproblem}}{\textbf{{\applycolor{main}{alt}\if\relax\detokenize{#1}\relax\else\hspace{3pt}(#1)\fi}}}\hspace{3.5pt}\ignorespaces
}
{
	\vspace{0.2cm}
}

\newcommand{\minpt}[1]{Minimum is {\applycolor{main}{alt}[#1\,\faPencil]}. Problems with the {\applycolor{main}{alt}\faDiamond} symbol are required.
	\vspace{\baselineskip}
}
% Specifies minimum amount of points for completion

\RequirePackage{soul}

\newcommand\ol[1]{{\setul{-0.9em}{}\ul{#1}}}

\newcommand{\psetquote}[2] % BE CAREFUL WITH THIS. must be DIRECTLY after minpt
{
	\vspace{-\baselineskip}
	\begin{flushright}
		\begin{tikzpicture}
			\draw (0,0) node [right,text width=8.75cm]{
				\begin{mdframed}[linecolor=darkblue,leftline=true,rightline=false,bottomline=false,topline=false,linewidth=3pt,backgroundcolor=thmblue]
					{``#1''}

					\vspace{1mm}

					\hfill\applycolor{main}{alt}\fell#2
				\end{mdframed}
			};

		\end{tikzpicture}
	\end{flushright}
}

\RequirePackage[letterpaper,top=2cm,bottom=2cm,left=2.5cm,right=2.5cm,includeheadfoot]{geometry} % geometry has to be BEFORE fancyhdr for margins to work!

\ifmast % Logo setup
	\RequirePackage{fancyhdr}
	\pagestyle{fancyplain}
	\renewcommand{\headrulewidth}{0pt} % clear header
	\fancyhead{} % clear line

	\fancyfoot[L]{\raisebox{-6pt}[0pt][0pt]{\includegraphics[width=3cm]{MASTlogo.png}}} % logo!
	\fancyfoot[C]{} % clear page number
	\fancyfoot[R]{\thepage}
\fi

\RequirePackage{etoolbox} % needed for hints and also title

%terrible hack for title - but fine

\ifbook
	\patchcmd{\@maketitle}{\@title}{\sffamily\bfseries\@title{}}{}{}
	\patchcmd{\@maketitle}{\@author}{\sffamily\textit{\@author}}{}{}
	\patchcmd{\@maketitle}{\@date}{\sffamily\@date}{}{}
\else
	\patchcmd{\@maketitle}{\@title}{\sffamily\applycolor{main}{alt}\bfseries\@title{}}{}{}
	\patchcmd{\@maketitle}{\@author}{\sffamily\@author}{}{}
	\patchcmd{\@maketitle}{\@date}{\sffamily\applycolor{main}{secondary}{\@date}}{}{}
\fi

\ifhint % Scrambled hints setup
	\RequirePackage{hintsol}
\fi

% font formatting

\RequirePackage[utf8]{inputenc}
\RequirePackage{pifont}
\RequirePackage[T1]{fontenc}

% more generic formatitng

\RequirePackage{amsthm,amssymb}
\RequirePackage{comment}
\RequirePackage{mathrsfs}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}
\RequirePackage{enumitem}
\RequirePackage{changepage}

\raggedbottom

% hyperref

\RequirePackage[hypertexnames=false]{hyperref}
\hypersetup{
	colorlinks,
	citecolor=black,
	filecolor=black,
	linkcolor=\getcolor{main}{primary},
	urlcolor=\getcolor{main}{primary}
}

% toc looks bad with hyperref

\newcommand{\toc}{
	{\hypersetup{
				citecolor=black,
				filecolor=black,
				linkcolor=black,
				urlcolor=black}
			\tableofcontents}
}

% theorem styles

\newtheoremstyle{dennistheo}%                % Name
{0pt}%                                     % Space above
{2pt}%                                     % Space below
{}%                                     % Body font
{}%                                     % Indent amount
{\color{darkblue}\sffamily\bfseries}%                            % Theorem head font
{}%                                    % Punctuation after theorem head
{1.5mm}%                                    % Space after theorem head, ' ', or \newline
{\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}}%                                     % Theorem head spec (can be left empty, meaning `normal')

\newtheoremstyle{def}%                % Name
{0pt}%                                     % Space above
{2pt}%                                     % Space below
{}%                                     % Body font
{}%                                     % Indent amount
{\color{darkgreen}\sffamily\bfseries}%                            % Theorem head font
{}%                                    % Punctuation after theorem head
{1.5mm}%                                    % Space after theorem head, ' ', or \newline
{\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}}%                                     % Theorem head spec (can be left empty, meaning `normal')

\newtheoremstyle{dennisexample}%                % Name
{0pt}%                                     % Space above
{2pt}%                                     % Space below
{}%                                     % Body font
{}%                                     % Indent amount
{\color{darkred}\sffamily\bfseries}%                            % Theorem head font
{}%                                    % Punctuation after theorem head
{1.5mm}%                                    % Space after theorem head, ' ', or \newline
{\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}}%

\newtheoremstyle{proof}
{0pt}
{0pt}
{}
{}
{\color{darkpurple}\sffamily\bfseries}
{:}
{1.5mm}
{\thmname{#1}\thmnote{ #3}}

\newtheoremstyle{remark}
{0pt}
{0pt}
{}
{}
{\color{black}\sffamily\bfseries}
{:}
{1.5mm}
{\thmname{#1}\thmnote{ #3}}

\newtheoremstyle{solution}
{0pt}
{0pt}
{}
{}
{\applycolor{main}{primary}\sffamily\bfseries}
{:}
{1.5mm}
{\thmname{#1}\thmnote{ #3}}

% theorems

\RequirePackage{mdframed}

\RequirePackage{tcolorbox}
\tcbuselibrary{skins}
\tcbuselibrary{breakable}
\tcbuselibrary{theorems}

\RequirePackage{titlesec}

\ifoldsec % old section

	\RequirePackage{marvosym}

	\titleformat{\section}
	{\sffamily\Large\bfseries}{{\applycolor{main}{alt}\Radioactivity\,\thesection}}{0.8em}{}

	% subsections
	\titleformat{\subsection}
	{\sffamily\large\bfseries}{{\applycolor{main}{alt}\thesubsection}}{0.9em}{}

	%subsubsections (just in case!)

	\titleformat{\subsubsection}
	{\sffamily\normalsize\bfseries}{{\applycolor{main}{alt}\thesubsubsection}}{0.9em}{}

\else
	%titling & sectioning from team.sty

	\newcommand{\sectioncolor}{\getcolor{main}{alt}} % in case I need to change this for any reason

	\titleformat{\section}{\normalfont\Large\bfseries\sffamily}{\color{\sectioncolor}{\S\,\thesection}}{1em}{\color{\sectioncolor}}[\color{\sectioncolor}\rule{\linewidth}{0.6mm}]
	\titleformat{\subsection}{\normalfont\large\bfseries\sffamily}{\color{\sectioncolor}{\S\,\thesubsection}}{1em}{\color{\sectioncolor}}[\color{\sectioncolor}]
	\titleformat{\subsubsection}{\normalfont\bfseries\sffamily}{\color{\sectioncolor}{\S\,\thesubsubsection}}{1em}{\color{\sectioncolor}}[\color{\sectioncolor}]
\fi

\ifbook

	\renewcommand\thepart{\Alph{part}} % make parts A,B,C,...

	% quotes at start of chapters, NEEDS CHANGEPAGE
	\newcommand{\chapterquote}[2]{
		\begin{adjustwidth}{10pt}{10pt}
			{\alegreyafont#1
				\begin{flushright}
					\textsl{#2}
					\\
				\end{flushright}}
		\end{adjustwidth}

	}

	% nuclear symbol for chapters and sections; book only

	\titleformat{\part}[display]
	{\alegreyafont\bfseries\huge\filcenter}
	{\partname\ \thepart}
	{20pt}
	{\Huge}
	\titlespacing*{\part}{0pt}{*36}{*1}

	\titleformat{\chapter}[display]
	{\alegreyafont\huge}{\chaptertitlename\ \thechapter}{20pt}{\Huge}[\titlerule]

	% theorem numberings different

	\theoremstyle{dennistheo}

	\newmdtheoremenv[% settings
		backgroundcolor=thmblue,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{theo}{Theorem}[chapter]

	\newmdtheoremenv[% settings
		backgroundcolor=thmblue,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{lemma}{Lemma}[chapter]

	\newmdtheoremenv[% settings
		backgroundcolor=thmblue,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{corollary}{Corollary}[chapter]

	\theoremstyle{def}

	\newmdtheoremenv[% settings
		backgroundcolor=thmgreen,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{fact}{Fact}[chapter]

	\newmdtheoremenv[% settings
		backgroundcolor=thmgreen,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{defi}{Definition}[chapter]

	\theoremstyle{dennisexample}

	\newmdtheoremenv[% settings
		backgroundcolor=thmred,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{exam}{Example}[chapter]

	\newmdtheoremenv[% settings
		backgroundcolor=thmred,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{exer}{Exercise}[chapter]

\else

	% theorem numbers same

	\theoremstyle{dennistheo}

	\newmdtheoremenv[% settings
		backgroundcolor=thmblue,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{theo}{Theorem}

	\newmdtheoremenv[% settings
		backgroundcolor=thmblue,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{lemma}{Lemma}

	\newmdtheoremenv[% settings
		backgroundcolor=thmblue,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{corollary}{Corollary}

	\theoremstyle{def}

	\newmdtheoremenv[% settings
		backgroundcolor=thmgreen,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{fact}{Fact}

	\newmdtheoremenv[% settings
		backgroundcolor=thmgreen,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{claim}{Claim}

	\newmdtheoremenv[% settings
		backgroundcolor=thmgreen,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{defi}{Definition}

	\theoremstyle{dennisexample}

	\newmdtheoremenv[% settings
		backgroundcolor=thmred,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{exam}{Example}

	\newmdtheoremenv[% settings
		backgroundcolor=thmred,
		nobreak=true,
		innerleftmargin=5pt,
		innerrightmargin=5pt,
		topline=false,
		bottomline=false,
		rightline=false,
		leftline=false]{exer}{Exercise}
\fi

\theoremstyle{proof}

\newmdtheoremenv[
	backgroundcolor=lightpurple,
	nobreak=true,
	innertopmargin=5pt,
	innerleftmargin=7pt,
	innerrightmargin=7pt,
	linecolor=darkpurple,
	linewidth=3pt,
	topline=false,
	bottomline=false,
	rightline=false,
	leftline=true]{pro}{Proof}

\theoremstyle{remark}

\newmdtheoremenv[
	backgroundcolor=remcolor,
	nobreak=true,
	innertopmargin=5pt,
	innerleftmargin=7pt,
	innerrightmargin=7pt,
	linecolor=black,
	linewidth=3pt,
	topline=false,
	bottomline=false,
	rightline=false,
	leftline=true]{remark}{Remark}

\renewcommand{\thepro}{\unskip}

\def\endpro{\hfill$\blacksquare$}

\theoremstyle{solution}

\newtheorem{sol}{Solution}

\newtheorem*{walk}{Walkthrough} % always use the enumerate environment during walkthroughs

\def\walk{{\applycolor{main}{primary}\sffamily\bfseries Walkthrough:} $\phantom{}$}

%custom bullet points

\newcommand{\Item}{\item[\ding{70}]} % k dis is just dumb

\renewcommand{\emph}[1]{{\applycolor{main}{alt}\bfseries#1}}

\newcommand{\pbold}[1]{{\applycolor{main}{secondary}\bfseries#1}}

\newcommand{\problem}[2]{\noindent{\pbold \if\relax\detokenize{#1}\relax\else#1. \fi}#2}

\RequirePackage{bm}

\newcommand{\ansbold}[1]{{\applycolor{main}{primary}\bm{#1}}}

\newcommand{\answer}[5]{\vspace{0.2cm}\noindent$\textbf{(A)}\ #1 \qquad\textbf{(B)}\ #2 \qquad\textbf{(C)}\ #3 \qquad\textbf{(D)}\ #4 \qquad\textbf{(E)}\ #5$}

\newcommand{\problems}{\pagebreak\section{Problems}}