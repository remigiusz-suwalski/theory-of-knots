\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{createspace}[2018/05/05 Create Space class]
\LoadClass[twoside, 9pt]{extbook}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{polski}

\RequirePackage{Alegreya}
\RequirePackage[tracking]{microtype}
\RequirePackage[compact]{titlesec}
% \RequirePackage[table]{xcolor} legacy stuff?
\RequirePackage[
    paperwidth=6.14in,
    paperheight=9.21in,
    left=0.82in,
    right=0.695in,
    top=0.6in,
    bottom=0.71in,
    twoside,
    headsep=0.15in,
    includehead,
    includefoot
]{geometry}

\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[C]{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\fancyhead[LE]{\thepage}
\fancyhead[RE]{\nouppercase{\leftmark}}
\fancyhead[LO]{\nouppercase{\rightmark}}
\fancyhead[RO]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.0pt}

\RequirePackage{amsmath} % \DeclareMathOperator
\RequirePackage{amssymb} % \mathbb
\RequirePackage{amsthm}  % \newtheorem 

\RequirePackage{float}      % figures with [H]
\RequirePackage{subcaption} % captions to subfigures

\RequirePackage[backref]{hyperref}

\theoremstyle{plain}
\newcounter{counter}
\numberwithin{counter}{section}
\newtheorem{conjecture}[counter]{Hipoteza}
\newtheorem{corollary}[counter]{Wniosek}
\newtheorem{definition}[counter]{Definicja}
\newtheorem{example}[counter]{Przyk\l{}ad}
\newtheorem{lemma}[counter]{Lemat}
\newtheorem{proposition}[counter]{Fakt}
\newtheorem{theorem}{Twierdzenie}
\newtheorem{warning}[counter]{Uwaga}