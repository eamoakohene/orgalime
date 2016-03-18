eng_utils <- R6::R6Class(
  "eng_utils",

  public = list(),

  private = list(

    db_name_local ='R:/packages/orgalime/inst/extdata/orgalime.sqlite',
    db_name_pkg = system.file("extdata/orgalime.sqlite",package="orgalime"),
    local_mode = TRUE

    ,get_db_con = function(){
      return(
        DBI::dbConnect(RSQLite::SQLite(), dbname= private$get_db() )
      )
    }

    ,run_sql = function(qry) {
      return(sqldf::sqldf(qry, dbname= private$db_name_local))#private$get_db()))
    }

    ,get_db = function(){

      if( private$local_mode ){
        return(private$db_name_local)
      }else{
        return(private$db_name_pkg)
      }
    }

    ,str_pos = function(x,pattern=","){
      my_str <- gregexpr(pattern =pattern,x)
      return(my_str[[1]][1])
    }
    ,split_str = function(q="EUR,GBP,USD"){
      my_str <- gsub(",","','",q)
      return (
        paste0("('",my_str,"')")
      )
    }
    ,set_decimal = function(x, k){
      if( !(is.na(x)||missing(x)||is.null(x)) ){
        if(x[1]<200){
          format(round(x, k), nsmall=k,big.mark=",")
        }else {
          format(round(x, 0), nsmall=0,big.mark=",")
        }
      }
    }
  )
)
