Config
  { font = "Lucida Grande Bold 13, Noto Sans CJK KR Bold 13",
    additionalFonts = ["Font Awesome 15"],
    bgColor = "#2E3440",
    fgColor = "#ECEFF4",
    position = BottomSize C 100 40,
    sepChar = "%",
    alignSep = "}{",
    template = " %StdinReader%  }{ %multicpu% %memory% %dynnetwork% %date% ",
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    overrideRedirect = True,
    pickBroadest = False,
    persistent = True,
    commands =
      [ Run
          DynNetwork
          ["--template", "<fc=#ebcb8b><fn=1>\xf0ac</fn></fc> <tx>/<rx>", "-w", "3", "-c", "0"]
          10,
        Run
          MultiCpu
          ["-t", "<fc=#bf616a><fn=1>\xf108</fn></fc> <autototal>", "-p", "2", "-c", "0", "-L", "10", "-H", "50", "--normal", "#ebcb8b", "--high", "#d08770"]
          10,
        Run
          Memory
          ["--template", "<fc=#d08770><fn=1>\xf2db</fn></fc> <usedratio>"]
          10,
        Run Date "<fc=#a3be8c><fn=1>\xf133</fn></fc> %a, %d %B %H:%M" "date" 100,
        Run StdinReader
      ]
  }
