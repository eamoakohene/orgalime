eng_data = R6::R6Class(
  'eng_data',
  inherit = eng_utils,
  public = list(

      groups = c(
        'economy',
        'earnings',
        'topsi',
        'exports',
        'total_orgalime',
        'topsi_orgalime',
        'inflation',
        'ppi_output',
        'ppi_output_orgalime',
        'ppi_input',
        'ppi_input_orgalime',
        'ppi_input_orgalime_core',
        'imports_cpa08',
        'exports_cpa08',
        'iop',
        'iop_orgalime',
        'iop_orgalime_core',
        'economy_pc',
        'ppi27',
        'emp_orgalime',
        'emp_male_orgalime',
        'emp_female_orgalime'

      ),
     grp = NULL

     ,initialize = function( grp){
       self$set_group(grp)
     }

     ,set_group = function(value){
       if(!missing(value) && !is.null(value)){
          self$grp <- value
       }
       invisible()
     }

     ,get_group = function(code_only = FALSE){

        my_sql <- sprintf("select * from trends_groups where grp='%s'", self$grp)
        my_data <- private$run_sql( my_sql)

        if(nrow(my_data) >0 && code_only){
          return(
            paste(my_data$code,sep='', collapse = ',')
          )
        }
        return(my_data)
     }

     ,view_groups = function(){
       return( self$groups)
     }

    ,add_currency_data = function(code,dt1,dt2,code_desc){
      #cat("Deleting old records ...\n")
      #private$run_sql(sprintf("delete from trends_data where data_code='%s'",code))

      cat("Starting update of ",code," @",format(Sys.time(), "%a %b %d %X %Y %Z"),"\n")
      df <- beamafx::fx_series$new(code)$set_date1(dt1)$set_date2(dt2)$set_freq('d')$get_data()
      #df <- dplyr::filter(df,data_code ==code)
      sql<- sprintf(
        paste0(
          "insert into trends_data (yr,mth,dy,data_unit,data_value,data_code,data_src,data_desc) values ",
          "(%i,%i,%i,'1 GBP',%s,'%s','ECB','%s')"
        ),
        df$yr, df$mth ,df$dy , round(df$value,5), df$data_code,code_desc
      )
      #return(sql)

      private$run_sql(sql)
      cat("Finished updating ",code," @",format(Sys.time(), "%a %b %d %X %Y %Z"),"\n")

      invisible(self)
    }

    ,add_ons_data = function(code,code_unit,code_desc,dt1,dt2=NULL){

      cat("Starting update of ",code," @",format(Sys.time(), "%a %b %d %X %Y %Z"),"\n")
      df <- onsR2::download(code=code,format='df')$m_data

      ndf <- NULL
      cat('ok so far \n')
      ndf$yr <- lubridate::year(df$date)
      ndf$mth <- lubridate::month(df$date)
      ndf$dy <- lubridate::day(df$date)
      ndf$value <- as.numeric(df$value)
      cat('ok so far \n')

      df <- dplyr::filter(as.data.frame(ndf),yr > lubridate::year(dt1) )
      cat('ok so far after filter\n')
      sql<- sprintf(
        paste0(
          "insert into trends_data (yr,mth,dy,data_unit,data_value,data_code,data_src,data_desc) values ",
          "(%i,%i,%i,'%s',%s, '%s','ONS','%s')"
        ),
        df$yr, df$mth ,df$dy, code_unit , round(df$value,5), code ,code_desc
      )
      #return(sql)

      private$run_sql(sql)
      cat("Finished updating ",code," @",format(Sys.time(), "%a %b %d %X %Y %Z"),"\n")

      invisible(self)
    }

  )#public

  ,private = list()

)#class
