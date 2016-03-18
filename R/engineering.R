
eng <- R6::R6Class(
  'eng',
  inherit = eng_utils,

  public = list(

    #data variables
    y1= 2010,
    y2=2020,
    m1=1,
    m2=12,
    d1=1,
    d2=31,
    code = NULL,
    fx = 'm',
    fx_list = c('d','m','q','y','mt','qt','yt','ms','qs','ys','mc','qc','yc'),
    fx_level = 2,
    pc_list = c('0','1','3','4','12'),
    pc = '0',
    dtd1 = NULL,
    dtd2 = NULL,
    is_avg = FALSE,

    #### plot variables
    is_group = FALSE,
    legend_x = 0.5,
    legend_y = 0.5,
    title ='',
    ylab = ' % Change ',
    colour = beamaColours::get_stats()[1],
    dt_breaks="3 months",
    dt_breaks_format="%b %Y",
    is_smooth=FALSE,
    dt_desc = '',
    freq = NULL,
    freq_default = 0,
    delta_x = 0,
    skale =1,


    y_lim = numeric(2),

    initialize = function(code){
      self$set_codes(code)
    }
    ,set_scale = function(value){

      if(!missing(value) && !is.null(value)){
        self$skale <- value
      }
      invisible(self)

    }
    ,set_delta_x = function(value){

       if(!missing(value) && !is.null(value)){
         self$delta_x <- value
       }
       invisible(self)

     }


    ,set_avg = function(value){

      if(!missing(value) && !is.null(value)){
        self$is_avg <- value
      }
      invisible(self)

    }
    ,set_fx = function(value){
      if(!missing(value) && !is.null(value)){
        self$fx <- value

        self$set_freq_default( self$fx )
      }
      invisible(self)
    }
    ,set_date1 = function(value){

      if(!missing(value) && !is.null(value)){
        my_date <- as.Date(value)

        self$set_y1( lubridate::year( my_date))
        self$set_m1( lubridate::month( my_date))
        self$set_d1( lubridate::day( my_date))
        self$set_data_days(1)
      }
      invisible(self)
    }

    ,set_date2 = function(value){
      if(!missing(value) && !is.null(value)){
        my_date <- as.Date(value)

        self$set_y2( lubridate::year( my_date))
        self$set_m2( lubridate::month( my_date))
        self$set_d2( lubridate::day( my_date))
        self$set_data_days(2)
      }
      invisible(self)
    }

    ,set_date_range = function(value1,value2){

      if(!missing(value1) && !is.null(value1)){
        self$set_date1(value1)
      }

      if(!missing(value2) && !is.null(value2)){
        self$set_date2(value2)
      }
      invisible(self)
    }
    ,set_data_days = function(value){

      if(value==1){
        self$dtd1 <- 372 * self$y1 + 31 * self$m1 + self$d1
      }else{
        self$dtd2 <- 372 * self$y2 + 31 * self$m2 + self$d2
      }
      invisible(self)
    }
    ,set_y1 = function(value){
      if(!missing(value) && !is.null(value)){
        self$y1 <- value
      }
      invisible(self)
    }
    ,set_y2 = function(value){
      if(!missing(value) && !is.null(value)){
        self$y2 <- value
      }
      invisible(self)
    }
    ,set_m1 = function(value){
      if(!missing(value) && !is.null(value)){
        self$m1 <- value
      }
      invisible(self)
    }

    ,set_m2 = function(value){
      if(!missing(value) && !is.null(value)){
        self$m2 <- value
      }
      invisible(self)
    }
    ,set_d1 = function(value){
      if(!missing(value) && !is.null(value)){
        self$d1 <- value
      }
      invisible(self)
    }
    ,set_d2 = function(value){
      if(!missing(value) && !is.null(value)){
        self$d2 <- value
      }
      invisible(self)
    }

    ,set_codes = function(value){
      if(!missing(value) && !is.null(value)){
        self$code <- private$split_str( value )
      }
      invisible(self)
    }
    ,set_pc = function(value){
      if(!missing(value) && !is.null(value)){
        self$pc <- value
      }
      invisible(self)
    }

    ,build_sql = function(){

      my_fx <- self$fx
      my_avg <- self$is_avg
      my_sql <- NULL
      my_group <- NULL
      my_order <- NULL


      if(my_fx=='q'){

        if(my_avg){

          my_sql <- "select yr,qtr,data_code,data_desc,avg(data_value)  as value from trends_data "
          my_group <- " group by yr,qtr,data_code,data_desc "
          my_order <- " order by yr,qtr,data_code,data_desc "

        }else{

          my_sql <- "select yr,qtr,data_code,data_desc,sum(data_value)  as value from trends_data "
          my_group <- " group by yr,qtr,data_code,data_desc "
          my_order <- " order by yr,qtr,data_code,data_desc "

        }

      }else if(my_fx=='m'){

        if(my_avg){

          my_sql <- "select yr,mth,data_code,data_desc,avg(data_value)  as value from trends_data "
          my_group <- "group by yr,mth,data_code,data_desc "
          my_order <- " order by yr,mth,data_code,data_desc "

        }else{

          my_sql <- "select yr,mth,data_code,data_desc,sum(data_value)  as value from trends_data "
          my_group <- " group by yr,mth,data_code,data_desc "
          my_order <- " order by yr,mth,data_code,data_desc "

        }

      }else if(my_fx=='y'){

        if(my_avg){

          my_sql <- "select yr,data_code,data_desc,avg(data_value)  as value from trends_data "
          my_group <- " group by yr,data_code,data_desc "
          my_order <- " order by yr,data_code,data_desc "

        }else{

          my_sql <- "select yr,data_code,data_desc,sum(data_value)  as value from trends_data"
          my_group <- " group by yr,data_code,data_desc "
          my_order <- " order by yr,data_code,data_desc "

        }

      }else   if(my_fx=='qt'){

        my_sql <- "select yr,qtr,sum(data_value)  as value from trends_data "
        my_group <- " group by yr,qtr "
        my_order <- " order by yr,qtr "

      }else if(my_fx=='mt'){

        my_sql <- "select yr,mth,sum(data_value)  as value from trends_data "
        my_group <- " group by yr,mth"
        my_order <- " order by yr,mth "

      }else if(my_fx=='yt'){

        my_sql <- "select yr,sum(data_value)  as value from trends_data "
        my_group <- " group by yr "
        my_order <- " order by yr "

      }else if(my_fx=='d'){

        my_sql <- "select yr,mth,dy,data_code,data_desc,data_value  as value from trends_data "
        my_order <- " order by yr,mth,dy,data_code,data_desc "

      }else if (my_fx=='ms'){

        my_sql <- paste0("SELECT yr, mth,substr(data_code, 6, length(data_code) - ",fx_level+6,") AS wrap, sum(data_value) as value  FROM trends_data ")
        my_group <- " group by yr,mth,wrap "

      }else if (my_fx=='qs'){

        my_sql <- paste0("SELECT yr, qtr,substr(data_code, 6, length(data_code) - ",fx_level+6,") AS wrap, sum(data_value) as value  FROM trends_data ")
        my_group <- " group by yr,qtr,wrap "

      }else if (my_fx=='ys'){

        my_sql <- paste0("SELECT yr, substr(data_code, 6, length(data_code) - ",fx_level+6,") AS wrap, sum(data_value) as value  FROM trends_data ")
        my_group <- " group by yr,wrap "

      }else if (my_fx=='mc'){

        my_sql <- paste0("SELECT yr, mth,(substr(data_code,instr(data_code,'EXP')+instr(data_code,'IMP'), length(data_code))) AS wrap, sum(data_value) as value  FROM trends_data")
        my_group <- " group by yr,mth,wrap "

      }else if (my_fx=='qc'){

        my_sql <- paste0("SELECT yr, qtr,(substr(data_code, instr(data_code,'EXP')+instr(data_code,'IMP'), length(data_code))) AS wrap, sum(data_value) as value  FROM trends_data ")
        my_group <- " group by yr,qtr,wrap "

      }else if (my_fx=='yc'){

        my_sql <- paste0("SELECT yr, ( substr(data_code, instr(data_code,'EXP')+instr(data_code,'IMP'), length(data_code))) AS wrap, sum(data_value) as value  FROM trends_data")
        my_group <- " group by yr,wrap "

      }


      q_code <- paste0(" data_code in ", self$code )
      q_yr <- paste0(" and (yr between ", self$y1, " and ", self$y2, ")")
      q_mth <- paste0(" and (mth between ", self$m1 ," and ", self$m2, ")")
      q_where <- paste0(" where ",q_code,q_yr,q_mth)

      my_sql <- paste0(my_sql,q_where,my_group,my_order)
      return(my_sql)
    }

    ,get_data = function(){

      my_data <- private$run_sql( self$build_sql() )
      my_fx <- self$fx
      my_pc <- as.numeric(self$pc)

      if(nrow(my_data)>0){

        my_data$value <- round(as.numeric(as.character(my_data$value)),4)

        if((my_fx=="m") || (my_fx=='mt')|| (my_fx=='ms')|| (my_fx=='mc')){
          my_data$dy <- 1
          if(my_fx=='mt'){
            my_data$data_code <- self$code
            my_data$data_desc <- 'dummy-desc'
          }
          if((my_fx=="ms")|| (my_fx=="mc")){
            my_data$data_code <- my_data$wrap
            my_data$data_desc <- my_data$data_code
          }
        }
        if((my_fx=="q") || (my_fx=="qt")|| (my_fx=="qs")|| (my_fx=="qc")){
          my_data$dy <- 1
          my_data$mth <- my_data$qtr*3
          if(my_fx=='qt'){
            my_data$data_code <- self$code
            my_data$data_desc <- 'dummy-desc'
          }

          if((my_fx=="qs")|| (my_fx=="qc")){
            my_data$data_code <- my_data$wrap
            my_data$data_desc <- my_data$data_code
          }
        }

        if((my_fx=="y")||(my_fx=="yt")||(my_fx=="ys")||(my_fx=="yc")){
              my_data$dy <- 1
              my_data$mth <-1
              if(my_fx=='yt'){
                    my_data$data_code <- self$code
                    my_data$data_desc <- 'dummy-desc'
              }
              if((my_fx=="ys")|| (my_fx=="yc")){
                    my_data$data_code <- my_data$wrap
                    my_data$data_desc <- my_data$data_code
              }
        }

        my_data<- dplyr::arrange(my_data,yr,mth,dy,data_desc)



        my_data$pc <- NULL
        if(my_pc > 0){

          my_k <- self$freq_default

          if(!is.null(self$freq)){ my_k <- self$freq}

          my_data$pc <- with(
            my_data,
            ave(
              value,
              data_code,
              FUN=function(x){quantmod::Delt(x,k= my_k)}
            )
          )*100

          }else{

          my_data$pc <- my_data$value
        }

      }#nrow
      return( my_data)
    }#get_data

    ,set_freq = function(value){
      if(!missing(value) && !is.null(value)){
        self$freq <- value

      }
      invisible(self)
    }
    ,set_freq_default = function(value){
      if(!missing(value) && !is.null(value)){
        self$freq_default <- switch(value,
                              'd' =1,
                              'm' = 12,
                              'q' = 4,
                              'y'=1)
      }
      invisible(self)
    }
    ,set_group = function(value){
      if(!missing(value) && !is.null(value)){
        self$is_group <- value
      }
      invisible(self)
    }


    ,set_title = function(value){
      if(!missing(value) && !is.null(value)){
        self$title <- value
      }
      invisible(self)
    }
    ,set_legend_xy = function(x,y){
      if(!missing(x) && !is.null(x)){
        self$legend_x <- x
      }
      if(!missing(y) && !is.null(y)){
        self$legend_y <- y
      }
      invisible(self)
    }

    ,set_ylab = function(value){
      if(!missing(value) && !is.null(value)){
        self$ylab <- value
      }
      invisible(self)
    }

    ,set_colour = function(value){
      if(!missing(value) && !is.null(value)){
        self$colour <- value
      }
      invisible(self)
    }


    ,set_breaks = function(value){
      if(!missing(value) && !is.null(value)){
        self$dt_breaks <- value
      }
      invisible(self)
    }
    ,set_breaks_fmt = function(value){
      if(!missing(value) && !is.null(value)){
        self$dt_breaks_fmt <- value
      }
      invisible(self)
    }

    ,set_smooth = function(value){
      if(!missing(value) && !is.null(value)){
        self$is_smooth <- value
      }
      invisible(self)
    }

    ,set_data_desc = function(value){
      if(!missing(value) && !is.null(value)){
        self$dt_desc <- value
      }
      invisible(self)
    }

    ,set_ylim = function(y1,y2){

      if(!missing(y1) && !is.null(y1)){
        self$y_lim[1] <- y1
      }
      if(!missing(y2) && !is.null(y2)){
        self$y_lim[2] <- y2
      }

      invisible(self)
    }


    ,plot_pc = function(brewer_set = "Set1",ytitle=''){

      my_data<- self$get_data()


      my_ylab <- ytitle
      my_pc <- as.numeric(self$pc)
      my_frq <- self$freq

      if(!(my_pc ==0 )){
              if(self$fx=="d"){
                my_ylab <- paste0(k,' day ',self$ylab)
              }else if((self$fx=="m") || (self$fx=='mt')){

                my_ylab <- paste0(my_frq,' month ',self$ylab)

              }else if((self$fx=="q") || (self$fx=='qt')){
                my_ylab <- paste0(my_frq,' quarter ',self$ylab)

              }else if((self$fx=="y") || (self$fx=='yt')){

                my_ylab <- " Yearly % change "

              }
      }



      if( (trimws(my_data$data_desc[1])=='dummy-desc') && (nchar(self$dt_desc)>0)){
        my_data$data_desc <- self$dt_desc
      }



      my_data <- dplyr::filter( my_data, !is.na(pc) )
      my_data$date <- as.Date( paste( my_data$yr, my_data$mth, my_data$dy, sep="-"))
      my_data$pc <- my_data$pc/self$skale

      mytext <- dplyr::filter( my_data, yr==self$y2, mth==self$m2)

      gmin <- NULL
      gmax <- NULL
      g <- NULL
      if(!self$is_group){

        my_data$data_days <- with(my_data,yr*372+mth*31+31)

        gmin <-  dplyr::filter(
                      dplyr::group_by(my_data ,data_code) ,
                      data_days==min(data_days)
                 )
        gmax <-  dplyr::filter(
                     dplyr::group_by(my_data,data_code),
                     data_days==max(data_days)
                 )

        gtxt <- rbind(gmin,gmax)

        #return(gtxt)

        g <- ggplot2::ggplot(my_data,ggplot2::aes(x=date,y=pc))
        g <- g + ggplot2::geom_line(size=1.5,colour = self$colour)
        g <- g + ggplot2::facet_wrap( ~ data_desc)
        g <- g + ggplot2::guides(colour=FALSE)
        # my_intercepts <- c(min(my_data$pc,na.rm=TRUE),max(my_data$pc,na.rm=TRUE))
        #
        g <- g+ ggplot2::geom_point(data=gtxt, ggplot2::aes(x=date,y=pc) ,size=5, colour = beamaColours::get_line_colour())
        g <- g+ ggplot2::geom_point(data=gtxt, ggplot2::aes(x=date,y=pc,colour = factor(data_days)) ,size=4 )
        g <- g+ ggplot2::geom_text(data=gtxt, ggplot2::aes(x=date,y=pc,label=private$set_decimal(pc,1)),vjust=-0.8,hjust=0.4,size=4,colour = beamaColours::get_smooth_colour())
        g <- g+ ggplot2::theme(legend.position="none")

        #g <- g + geom_hline(yintercept=my_intercepts,colour=colour_set,linetype='dashed')
      }else{
                g <- ggplot2::ggplot(my_data, ggplot2::aes(x=date,y=pc,colour=data_code))
                g <- g + ggplot2::geom_line( ggplot2::aes(group=data_code),size=1.3)
                g <- g+ ggplot2::theme(
                  legend.position = c(self$legend_x, self$legend_y),
                  legend.background = element_rect(fill = NA, colour = NA),#lgpos$fill
                  legend.title=element_blank(),
                  text = element_text(12)
                )
                g <- g+ ggplot2::scale_colour_brewer( palette = brewer_set )

      }

      g <- g + ggplot2::labs(title= self$title,x="",y = my_ylab)
      g <- g + ggplot2::geom_hline(ggplot2::aes(yintercept=0))



      if( !(self$y_lim[1] == 0) ){
              g <- g + ggplot2::ylim( self$y_lim )
      }

      if( !(self$delta_x == 0) ){

        min_date <- as.Date( paste( gmin$yr[1], gmin$mth[1], 28,sep='-'))
        max_date <- as.Date( paste( gmax$yr[1], gmax$mth[1], 28,sep='-'))

        #return(list(min_date,max_date))

        lubridate::month(max_date) <- lubridate::month(max_date) + self$delta_x
        lubridate::month(min_date) <- lubridate::month(min_date) - self$delta_x

        ##test
        #return(list(min_date,max_date))
        ###

        g <- g + ggplot2::xlim( min_date,max_date )
      }

      print(g)
      return(my_data)
    }

    ,plot_save = function(
      file="glance.png",width=650,height=390,path="M:/2016-03-06-saariselka-finalnd/graphics/",ppi=72
    ){
      ggplot2::ggsave(file=paste0(path,file,".png"),height=height/ppi,width=width/ppi,dpi=ppi,units="in")
    }


  ,plot_dt= function(ytitle='',brewer_set = "Set1"){


    mycolour <- brewer_set

    mydata<- self$get_data()
    myfx <- self$fx
    my_ylab <- NULL
    if(myfx=="d"){
      my_ylab <- paste0(ytitle , '(daily)')
    }else if((myfx=="m") || (myfx=='mt')){

      my_ylab <- paste0(ytitle, ' - monthly ')

    }else if((myfx=="q") || (myfx=='qt')){
      my_ylab <- paste0(ytitle,' - quarterly ')

    }else if((myfx=="y") || (myfx=='yt')){

      my_ylab <- paste0(ytitle,' - yearly ')

    }

    my_scale <- self$skale
    mydata$value <- as.numeric(mydata$value)/my_scale
    yscale <-''

    if(my_scale==1e3){
      yscale <- paste0('(thousands)')
    }
    else if(my_scale==1e6){
      yscale <- paste0('(millions)')
    }
    else if(my_scale==1e9){
      yscale <- paste0('(billions)')
    }

    mydata$date <- as.Date(paste(mydata$yr,mydata$mth,mydata$dy,sep="-"))

    is_brewer <- (length(grep('#',mycolour))==0)



    g <- NULL
    if(!self$is_group){

      mydata$data_days <- with(mydata,yr*372+mth*32+dy)
      gmin <-  dplyr::filter( dplyr::group_by(mydata,data_code), data_days==min(data_days))
      gmax <-   dplyr::filter(dplyr::group_by(mydata,data_code),data_days==max(data_days))
      gtxt <- rbind(gmin,gmax)


      g <- ggplot2::ggplot(mydata,ggplot2::aes(x=date,y=value))
      g <- g+ggplot2::facet_wrap( ~ data_desc)
      g <- g+ggplot2::guides(colour=FALSE)


      g <- g+ ggplot2::geom_point(data=gtxt, ggplot2::aes(x=date,y=value),size=5,colour=beamaColours::get_line_colour())
      g <- g+ ggplot2::geom_point(data=gtxt, ggplot2::aes(x=date,y=value,colour=factor(data_days)),size=4)
      g <- g+ ggplot2::geom_text(data=gtxt, ggplot2::aes(x=date,y=value,label=private$set_decimal(value,1)),vjust=-0.8,hjust=0.4,size=4,colour=beamaColours::get_smooth_colour())
      g <- g+ ggplot2::theme(legend.position="none")


      # if(is_brewer){
      #
      #   g<- g+geom_line(size=1.4,aes(colour=data_code))
      #   g <- g + scale_colour_brewer(palette=mycolour)
      #
      # }else{
        g <- g +ggplot2::geom_line(size=1.5,colour=self$colour)
      # }

    }else{
      g <- ggplot2::ggplot(mydata,ggplot2::aes(x=date,y=value,colour=data_code))
      g <- g + ggplot2::geom_line( ggplot2::aes(group=data_code),size=1.3)
      g <- g + ggplot2::scale_colour_brewer(palette=mycolour)
      g <- g + ggplot2::theme(
        legend.position = c(lgpos$x, lgpos$y),
        legend.background = element_rect(fill = NA, colour = NA),#lgpos$fill
        legend.title=element_blank(),
        text = element_text(12)
      )

    }
#
#     if( !(self$y_lim[1] == 0) ){
#       g <- g + ylim( self$y_lim )
#     }

    if( !(self$delta_x == 0) ){

      min_date <- as.Date( paste( gmin$yr[1], gmin$mth[1], 28,sep='-'))
      max_date <- as.Date( paste( gmax$yr[1], gmax$mth[1], 28,sep='-'))

      #return(list(min_date,max_date))

      lubridate::month(max_date) <- lubridate::month(max_date) + self$delta_x
      lubridate::month(min_date) <- lubridate::month(min_date) - self$delta_x



      g <- g + ggplot2::xlim( min_date,max_date )
    }
    g <- g + ggplot2::labs(title=self$title, x="",y=paste(my_ylab,yscale))
    if(self$is_smooth){
      g <- g + ggplot2::geom_smooth(method='lm',colour='red')
    }
    #g <- g + geom_hline(aes(yintercept=0))


    print(g)
    return(mydata)
  }
    ,add_to_db = function(grp,df){

      if(missing(df)){
        cat("Please supply data frame \n")
        return(NULL)
      }
      my_df <- df
      my_df$grp <- grp

      my_sql <- sprintf(
        "insert into trends_groups (grp,code,description,freq) values ('%s','%s','%s','%s');",
        my_df$grp, my_df$code, my_df$desc, my_df$freq
      )

      private$run_sql(my_sql)


    }

 )
  ,private = list(



  )

)
