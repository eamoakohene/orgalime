
### 1.0  Index of production
# eng$new(
#   eng_data$new('iop_orgalime')$get_group(T)
# )$set_y1(2014)$set_avg(T)$set_delta_x(1)$plot_pc()

# eng$new()$plot_save('iop')

#  eng$new(
#     eng_data$new('iop_orgalime')$get_group(T)
#  )$set_y1(2011)$set_avg(T)$set_delta_x(1)$plot_pc()

# eng$new()$plot_save('iop_long')

#

# ### Production levels still below pre-recession levels
# eng$new(
# eng_data$new('iop_orgalime')$get_group(T)
# )$set_y1(2008)$set_avg(T)$set_fx('y')$set_ylim(-1,130)$set_delta_x(6)$set_pc('0')$plot_pc(ytitle='Yearly Index (2010=100)')

#eng$new()$plot_save('iop_index_4')
#
# ### Production levels above prerecession levelsl
# eng$new(
#   paste(
#     eng_data$new()$iop_orgalime()$code[c(5,6)],
#     sep='',
#     collapse=","
#   )
# )$set_y1(2008)$set_avg(T)$set_fx('y')$set_ylim(-1,150)$set_delta_x(6)$set_pc('0')$plot_pc(ytitle='Yearly Index (2010=100)')
# eng$new()$plot_save('iop_index_2')

#### 2.0 Turnover
#abc <- sprintf(" UPDATE trends_data SET data_desc = '%s' WHERE data_code='%s';",desc,code)
#run_sql(abc)
##long-term-trends

# eng$new(
#   eng_data$new('topsi_orgalime')$get_group(T)
# )$set_y1(2008)$set_avg(F)$set_scale(1000)$set_fx('y')$set_delta_x(6)$set_ylim(-1,40)$plot_pc(ytitle='Annual Turnover (GBP billion)')
# eng$new()$plot_save('turnover_yearly')

# ##long-term-trends
# eng$new(
#   eng_data$new('topsi_orgalime')$get_group(T)
# )$set_y1(2009)$set_avg(T)$set_fx('y')$set_delta_x(6)$set_pc('1')$set_ylim(-30,50)$plot_pc()
# eng$new()$plot_save('turnover_pc_yr')

##short-term trends
# eng$new(
#   eng_data$new('topsi_orgalime')$get_group(T)
# )$set_y1(2014)$set_avg(F)$set_fx('m')$set_delta_x(1)$set_pc('12')$set_ylim(-20,15)$plot_pc()
# eng$new()$plot_save('turnover_pc_mth')

#3. Exports
# eng$new(
#   eng_data$new('exports')$get_group(T)
# )$set_y1(2006)$set_avg(F)$set_fx('y')$set_scale(1000)$set_delta_x(12)$set_pc('0')$set_ylim(-1,20)$plot_pc(ytitle="Annual Turnover (GBP billions)")
# eng$new()$plot_save('exports_yr2')

# eng$new(
# eng_data$new('exports')$get_group(T)
# )$set_y1(2014)$set_avg(F)$set_fx('m')$set_delta_x(1)$set_pc('12')$set_ylim(-30,50)$plot_pc()
# eng$new()$plot_save('exports_pc_mth')
#
# eng$new(
# eng_data$new('exports')$get_group(T)
# )$set_y1(2006)$set_avg(F)$set_fx('y')$set_delta_x(1)$set_pc('1')$set_ylim(-50,100)$plot_pc()
# eng$new()$plot_save('exports_pc_yr')
#
# eng$new(
# eng_data$new('exports')$get_group(T)
# )$set_y1(2015)$set_avg(F)$set_fx('m')$set_delta_x(1)$set_pc('0')$set_ylim(-15,1500)$plot_pc()
# eng$new()$plot_save('exports_val_mth')

# eng$new(
#   paste(
#     eng_data$new()$exports()$code[-c(6)],
#     sep='',
#     collapse=","
#   )
# )$set_y1(2014)$set_avg(F)$set_fx('m')$set_delta_x(1)$set_pc('12')$set_ylim(-40,50)$plot_pc()
# eng$new()$plot_save('exports_pc_mth')
#
#   eng$new(
#   eng_data$new('exports')$get_group(T)
#   )$set_y1(2014)$set_avg(F)$set_fx('m')$set_delta_x(0)$set_pc('12')$set_ylim(-40,400)$plot_pc(dazzle=T)
# eng$new()$plot_save('exports_pc_mth_ammunitions')

  # orgalime::eng$new(
  #   orgalime::eng_data$new('currency')$get_group(T)
  # )$set_y1(2010)$set_avg(T)$set_fx('m')$set_delta_x(2)$set_pc('12')$set_ylim(-30,50)$plot_pc(dazzle=T)



  #abc <- beamafx::fx_series$new('CNY')$set_date1('2006/01/01')$set_date2('2017/01/01')$set_freq('d')$get_data()
  #abc <- beamafx::fx_series$new('BRL')$set_date1('2008/01/01')$set_date2('2017/01/01')$set_freq('d')$get_data()
  #abc <- beamafx::fx_series$new('INR')$set_date1('2009/01/01')$set_date2('2017/01/01')$set_freq('d')$get_data()

  #abc <- beamafx::fx_series$new('USD')$set_date1('2000/01/01')$set_date2('2017/01/01')$set_freq('d')$get_data()
  #abc <- beamafx::fx_series$new('EUR')$set_date1('2000/01/01')$set_date2('2017/01/01')$set_freq('d')$get_data()
  #abc <- beamafx::fx_series$new('JPY')$set_date1('2000/01/01')$set_date2('2017/01/01')$set_freq('d')$get_data()
#
#   eng_data$new()$add_currency_data('USD','2000/01/01','2017/01/01','USD - US Dollar($)')
#   eng_data$new()$add_currency_data('EUR','2000/01/01','2017/01/01','EUR - Euro (€)')
#   eng_data$new()$add_currency_data('JPY','2000/01/01','2017/01/01','JPY - Japanese (¥)')
#   eng_data$new()$add_currency_data('CNY','2006/01/01','2017/01/01','CNY - Chinese Yuan Renminbi (¥)')
#   eng_data$new()$add_currency_data('INR','2009/01/01','2017/01/01','INR - Indian Rupee')
#   eng_data$new()$add_currency_data('BRL','2008/01/01','2017/01/01','BRL - Brazillian Real (R$)')
  #
# eng$new(
#   paste(
#     eng_data$new()$exports()$code[c(6)],
#     sep='',
#     collapse=","
#   )
# )$set_y1(2008)$set_avg(F)$set_scale(1)$set_fx('m')$set_delta_x(0)$set_pc('0')$set_ylim(-1,100)$plot_dt('Turnover (GBP millions)')
# eng$new()$plot_save('exports_valc_mth_ammunitions')
#
# eng$new(
#   paste(
#     eng_data$new()$exports()$code[c(6)],
#     sep='',
#     collapse=","
#   )
# )$set_y1(2000)$set_avg(F)$set_scale(1000)$set_fx('y')$set_delta_x(0)$set_pc('0')$set_ylim(-1,100)$plot_dt('Turnover (GBP billions)')
# eng$new()$plot_save('exports_val_yr_ammunitions')

# eng$new(
#   paste(
#     eng_data$new()$exports()$code,
#     sep='',
#     collapse=","
#   )
# )$set_y1(201)$set_avg(F)$set_fx('m')$set_delta_x(1)$set_ylim(0,1800)$plot_dt('Turnover - GBP millions')
# eng$new()$plot_save('exports_val_mth')

#### Exports
# eng$new(
#   eng_data$new('exports')$get_group(T)
# )$set_y1(201)$set_avg(F)$set_fx('y')$set_delta_x(1)$set_ylim(0,1800)$plot_dt('Turnover - GBP millions')
# eng$new()$plot_save('exports_val_mth')

# abc <- sprintf(" UPDATE trends_data SET data_desc = '%s' WHERE data_code='%s';",desc,code)
#run_sql(abc)

# orgalime::eng$new()$add_to_db(
#   "emp_female_orgalime",
#   orgalime::eng_data$new()$emp_female_orgalime()
# )

#eng_data$new('economy')$get_group()
#eng_data$new('economy')$get_group(T)
