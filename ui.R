

#' Valid statuses are: primary, success, info, warning,
#' danger, navy, teal, purple, orange, maroon, black.

left_menu <- tagList(
  dropdownBlock(
    id    = "download-menu",
    title = "Download",
    icon  = icon("download"),

    downloadButton(
      outputId = "download_data",
      label    = "Data",
      icon     = icon("download")
    ),

    conditionalPanel(
      condition = "input.sidebar == 'individual' ",

      downloadButton(
        outputId = "downloadreport_individual",
        label    = "Report",
        icon     = icon("download")
      )
    ),

    conditionalPanel(
      condition = "input.sidebar == 'overview' ",

      downloadButton(
        outputId = "downloadreport_overview",
        label    = "Report",
        icon     = icon("download")
      )
    )
  ),

  actionButton(
    inputId = "contact",
    label   = "Contact",
    icon    = icon("phone")
  )
)


header <- dashboardHeaderPlus(
  left_menu  = left_menu,
  fixed      = F,
  title      = paste0("TBI Projects")
)


sidebar_menu <- sidebarMenu(
  id = "sidebar",

  menuItem(
    text    = "Overview",
    tabName = "overview",
    icon    = icon("globe-africa")
  ),

  menuItem(
    text    = "Individual",
    tabName = "individual",
    icon    = icon("search")
  ),

  menuItem(
    text    = "About",
    tabName = "explanations",
    icon    = icon("info")
  )

)


sidebar <- dashboardSidebar(sidebar_menu)


rightsidebar <- rightSidebar(
  title = "Right Sidebar",
  background = "dark",

  rightSidebarTabContent(
    id     = 1,
    title  = "Tab 1",
    icon   = "desktop",
    active = T,
    sliderInput(
      inputId = "obs",
      label   = "Number of observations:",
      min     = 0,
      max     = 1000,
      value   = 500
    )
  ),

  rightSidebarTabContent(
    id    = 2,
    title = "Tab 2",
    textInput(inputId = "caption",
              label = "Caption",
              "Data Summary")
  ),

  rightSidebarTabContent(
    id    = 3,
    icon  = "paint-brush",
    title = "Tab 3",
    numericInput(
      inputId = "obs",
      label = "Observations:",
      value = 10,
      min   = 1,
      max   = 100
    )
  )
)


body <- dashboardBody(tabItems(
  tabItem(
    tabName = "overview",

    fluidRow(
      column(
        width = 12,

        boxPlus(
          width = 12,
          status = "primary",
          background    = NULL,
          boxToolSize   = "md",
          closable      = F,
          collapsible   = T,
          title = "Health Status",
          footer = tagList(
            dashboardLabel("Green Health", status = "success"),
            dashboardLabel("Yellow Health", status = "warning"),
            dashboardLabel("Red Health", status = "danger")
          ),


          #' @todo: code should be repeated call to a function, not so much
          #' copy and pasting...

          box(
            width = 3,
            status = "primary",
            title = "All Projects",
            solidHeader = T,
            tags$h4("On Track"),
            tagList(apply(
              X = on_track,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Caution"),
            tagList(apply(
              X = caution,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Delayed"),
            tagList(apply(
              X = delayed,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            ))
          ),


          box(
            width = 3,
            title = "Investment Planning Projects",
            status = "primary",
            solidHeader = T,
            tags$h4("Stage 1: Initiation"),
            #' @todo: please make the color reflect project health?!
            #' I have started the function colorfulDashboardBadge, needs
            #' implementation.
            tagList(apply(
              X = ipp_stage_1,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stage 2: Planning"),
            tagList(apply(
              X = ipp_stage_2,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stage 3: Execution"),
            tagList(apply(
              X = ipp_stage_3,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stage 4: Closure"),
            tagList(apply(
              X = ipp_stage_4,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            ))
          ),



          box(
            width = 3,
            title = "Other IT Projects",
            status = "primary",
            solidHeader = T,
            tags$h4("Stage 1: Initiation"),
            tagList(apply(
              X = a_stage_1,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stage 2: Planning"),
            tagList(apply(
              X = a_stage_2,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stage 3: Execution"),
            tagList(apply(
              X = a_stage_3,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stage 4: Closure"),
            tagList(apply(
              X = a_stage_4,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            ))
          ),


          box(
            width = 3,
            solidHeader = T,
            status = "primary",
            title = "Innovation Projects",
            tags$h4("Stream I (Planning)"),
            tagList(apply(
              X = stream_1,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))
            )),
            br(),
            br(),
            tags$h4("Stream II (Testing)"),
            tagList(apply(
              X = stream_2,
              MARGIN = 1,
              FUN = function(x)
                (colorfulDashboardBadge(x))))
          )
        )
      ),


      column(
        width = 12,
        box(
          status = "info",
          collapsible = T,
          closable = F,
          title = "Overall Budget",
          width = 12,
          uiOutput("project_portfolio_budget")
        )
      ),

      column(
        width = 12,

        box(
          width = 12,
          collapsible = T,
          closable = F,
          title = "Budget Details",
          status = "success",
          box(
            width = 4,
            collapsible = F,
            closable = F,
            title = "Investment Planning Projects",
            status = "success",
            solidHeader = T,
            withSpinner(plotlyOutput("ip_projects_health"))
          ),

          box(
            width = 4,
            collapsible = F,
            closable = F,
            title = "Other IT Projects",
            solidHeader = T,
            status = "success",
            withSpinner(plotlyOutput("a_team_projects_health"))
          ),

          box(
            width = 4,
            collapsible = F,
            closable = F,
            title = "Innovation Projects",
            solidHeader = T,
            status = "success",
            withSpinner(plotlyOutput("innovation_projects_health"))
          ),
          footer = tagList(
            dashboardLabel("On Track", status = "success"),
            dashboardLabel("Caution", status = "warning"),
            dashboardLabel("Delayed", status = "danger")
          )
        )
      ),


      column(
        width = 12,
        boxPlus(
          status = "navy",
          collapsible = T,
          closable = F,
          width = 12,
          title = "Fiscal Year Schedule",
          footer = tagList(
            dashboardLabel("On track to be completed within 3 months of approved finish date.", status = "success"),
            dashboardLabel("Delayed by 3 to 6 months.", status = "warning"),
            dashboardLabel("More than 6 months delayed.", status = "danger")
          ),
          box(
            title = "Filters by project status:",
            width = 3,
            radioButtons(
              "timevis_data_radio",
              label = "",
              choices = list(
                "Default view" = "default",
                "Only late" = "late",
                "Only on time" = "ontime",
                "Only completed" = "completed",
                "Show everything" = "all"
              ),
              selected = "default"
            )
          ),

          box(
            title = "Filter by date:",
            width = 3,
            actionButton("timevis_quarter", "Only this quarter"),
            actionButton("timevis_year", "Only this year")
          ),
          box(
            width = 3,
            title = "Custom date range:",
            dateRangeInput(
              start = min_date,
              end = max_date,
              inputId = "main-page-date-slider",
              label = "",
              min = min_date,
              max = max_date
            )
          ),
          box(
            title = "Adjust view:",
            width = 3,
            actionButton("timevis_center", "Center around today"),
            actionButton("timevis_fit", "Fit all")
          ),
          br(),
          br(),
          box(width = 12,
              withSpinner(timevisOutput("timevis_plot_all")))
        )
      )
      #' @todo: need to remove logout button, these br() are a work-aroud.

    ),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br()

  ),


  tabItem(
    tabName = "individual",

    column(
      width = 12,


      box(
        title = textOutput("project_name"),
        status = "info",
        width = 12,
        solidHeader = T,

        box(
          solidHeader = T,
          status = "info",
          width = 4,
          selectInput(
            inputId = "selectip",
            label   = "Select a Project:",
            choices = ip
          )
        ),
        box(
          width = 8,
          status = "info",
          textOutput("individual_project_description")
        ),

        box(
          solidHeader = F,
          title = "Status",
          status = "info",
          width = 12,
          valueBoxOutput("overall"),
          valueBoxOutput("overall_stage"),
          valueBoxOutput("directorate")
        )

      )
    ),

    column(width = 12,
           fluidRow(
             width = 12,
             box(
               width = 12,
               title = "Budget",
               status = "info",
               solidHeader = F,
               boxPlus(
                 title = "Project Budget",
                 status = "info",
                 solidHeader = T,
                 width = 8,
                 withSpinner(plotlyOutput("budget_plt")),
                 footer =
                   tagList(
                     dashboardBadge("Project Expenditure",            color = "purple"),
                     dashboardBadge("Project Authority: Non Capital", color = "teal"),
                     dashboardBadge("Project Authority: Capital",     color = "orange")
                   )
               ),
               uiOutput("project_portfolio_budget_individual")
             )
           )),

    column(
      width = 12,
      box(
        title = "Project Risks",
        width = NULL,
        dataTableOutput("proj_risk_tb")
      )
    ),

    column(
      width = 12,
      box(
        title = "Project Issues",
        width = NULL,
        dataTableOutput("proj_issue_tb")
      )
    ),

    fluidRow(column(
      width = 12,
      box(
        width = 12,
        title = "Schedule",
        withSpinner(timevisOutput("timevis_plot_individual"))
      )
    ))
  ),

  tabItem(tabName = "explanations",

          fluidRow(width = 12,
                   column(
                     width = 12,
                     includeHTML("explanations.html")
                   )))
))


ui <- secure_app(
  head_auth = tags$script(inactivity),

  dashboardPagePlus(
    useShinyjs(),
    collapse_sidebar = T,
    header       = header,
    sidebar      = sidebar,
    rightsidebar = rightsidebar,
    body         = body,
    tags$head(tags$style(
      HTML(
        "
                        .incomplete-within-3-months {
                           background-color: rgba(0, 255, 0, 0.1);
                           border: 2px solid rgba(0, 255, 0, 1);
                           border-radius: 3px;
                           margin: -7px -7px -7px -7px;
                         }

                         .completed-within-3-months {
                           background-color: rgba(0, 0, 0, 0.5);
                           border: 2px solid rgba(0, 0, 0, 0.5);
                           border-radius: 3px;
                           margin: -7px -7px -7px -7px;
                         }

                        .completed-within-3-months * {
                         color: rgba(0, 0, 0, 0.3);
                        }


                         .completed-within-3-to-6-months {
                           background-color: rgba(0, 0, 0, 0.5);
                           border: 2px solid rgba(0, 0, 0, 0.5);
                           border-radius: 3px;
                           margin: -7px -7px -7px -7px;
                         }

                         .completed-within-3-to-6-months * {
                         color: rgba(0, 0, 0, 0.3);
                        }

                         .completed-more-than-6-months {
                           background-color: rgba(0, 0, 0, 0.5);
                           border: 2px solid rgba(0, 0, 0, 0.5);
                           border-radius: 3px;
                           margin: -7px -7px -7px -7px;
                         }


                        .completed-more-than-6-months * {
                         color: rgba(0, 0, 0, 0.3);
                        }

                        .incomplete-within-3-to-6-months {
                         background-color: rgba(255, 255, 0, 0.1);
                         border: 2px solid rgba(255, 255, 0, 1);
                         border-radius: 3px;
                         margin: -7px -7px -7px -7px;
                        }

                        .incomplete-more-than-6-months {
                         background-color: rgba(255, 0, 0, 0.1);
                         border: 2px solid rgba(255, 0, 0, 1);
                         border-radius: 3px;
                         margin: -7px -7px -7px -7px;
                        }

                      "
      )
    ))
  )
)
