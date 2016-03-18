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



  )#public

  ,private = list()

)#class
