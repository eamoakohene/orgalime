


# ##view and download as necessay
# beamafx::fx_tbl_tail(n=10, where = "data_code='EUR'", order_by ="yr,mth,dy")
# beamafx::fx_download$new()$set_data_points(30)$update_euro_all()
#
# ##get data for reports
# cur_raw <- beamafx::fx_series$new('USD,EUR,JPY,CNY,BRL,INR')$set_date1('2014/01/01')$set_date2('2016/04/30')$set_freq('m')$get_data()
# cur_raw$qtr <- cur_raw$dy <- NULL
# cur_format <- tidyr::spread(cur_raw,data_code,value)
# orgalime::eng$new()$to_clipboard(cur_format)


#   dt1 <- 01/04/2016
#   dt2 <- 30/04/2016
#   orgalime::eng_data$new()$add_currency_data('USD',dt1,dt2,'USD - US Dollar($)')
#   orgalime::eng_data$new()$add_currency_data('EUR',dt1,dt2,'EUR - Euro (€)')
#   orgalime::eng_data$new()$add_currency_data('JPY',dt1,dt2,'JPY - Japanese (¥)')
#   orgalime::eng_data$new()$add_currency_data('CNY',dt1,dt2,'CNY - Chinese Yuan Renminbi (¥)')
#   orgalime::eng_data$new()$add_currency_data('INR',dt1,dt2,'INR - Indian Rupee')
#   orgalime::eng_data$new()$add_currency_data('BRL',dt1,dt2,'BRL - Brazillian Real (R$)')

##currencies
#   eng$new(
#     orgalime::eng_data$new('currency')$get_group(T)
#   )$set_y1(2012)$set_avg(T)$set_fx('m')$set_delta_x(2)$set_pc('12')$set_ylim(-20,60)$plot_pc(ytitle="12-month % change",dazzle=T)
#
#   eng$new()$plot_save(
#     file="exchange_rates2",width=592,height=310, path='W:/reports/latex/images/'
#   )
#
#   dt1 <- '2014-12-31'
#   dt2 <- '2017-12-31'

#   orgalime::eng_data$new()$add_ons_data(code = 'D7BT', code_unit = '2015=100', code_desc = 'CPI - All Items (D7BT)',dt1=dt1)
#   orgalime::eng_data$new()$add_ons_data(code = 'K646', code_unit = '2005=100', code_desc = 'PPI: Input Prices (K646)' ,dt1=dt1)
#   orgalime::eng_data$new()$add_ons_data(code = 'JVZ7', code_unit = '2005=100', code_desc = 'PPI: Output Prices (JVZ7)' ,dt1=dt1)
#   orgalime::eng_data$new()$add_ons_data(code = 'CHAW', code_unit = '2005=100', code_desc = 'RPI - All Items (CHAW)' ,dt1=dt1)

####inflation
# eng$new(
#   'CHAW,D7BT,JVZ7,K646'
# )$set_y1(2011)$set_avg(T)$set_fx('m')$set_delta_x(2)$set_pc('12')$set_ylim(-15,10)$plot_pc(ytitle="12-month % change",dazzle=T)
#
# eng$new()$plot_save(
#   file="uk_inflation_rates2",width=592,height=370, path='W:/reports/latex/images/'
# )


