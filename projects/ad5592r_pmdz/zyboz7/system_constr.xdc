
# 1. Update the signals names for both JC and JD PMOD connectors

##Pmod Header JC   ADC PMOD CONNECTOR

set_property -dict { PACKAGE_PIN V15  IOSTANDARD LVCMOS33 } [get_ports { adc_spi_cs   }]; #IO_L10P_T1_34 Sch=jc_p[1]   			 
set_property -dict { PACKAGE_PIN W15  IOSTANDARD LVCMOS33 } [get_ports { adc_spi_mosi }]; #IO_L10N_T1_34 Sch=jc_n[1]		     
set_property -dict { PACKAGE_PIN T11  IOSTANDARD LVCMOS33 } [get_ports { adc_spi_miso }]; #IO_L1P_T0_34 Sch=jc_p[2]              
set_property -dict { PACKAGE_PIN T10  IOSTANDARD LVCMOS33 } [get_ports { adc_spi_clk }]; #IO_L1N_T0_34 Sch=jc_n[2]              
#set_property -dict { PACKAGE_PIN W14  IOSTANDARD LVCMOS33 } [get_ports { /*here*/ }]; #IO_L8P_T1_34 Sch=jc_p[3]              
#set_property -dict { PACKAGE_PIN Y14  IOSTANDARD LVCMOS33 } [get_ports { /*here*/ }]; #IO_L8N_T1_34 Sch=jc_n[3]              
#set_property -dict { PACKAGE_PIN T12  IOSTANDARD LVCMOS33 } [get_ports { /*here*/ }]; #IO_L2P_T0_34 Sch=jc_p[4]              
#set_property -dict { PACKAGE_PIN U12  IOSTANDARD LVCMOS33 } [get_ports { /*here*/ }]; #IO_L2N_T0_34 Sch=jc_n[4]     


                                                                                                                                                                                                                                                           
##Pmod Header JD   SNIFFING PMOD CONNECTOR

set_property -dict { PACKAGE_PIN T14  IOSTANDARD LVCMOS33  } [get_ports { sniff_spi_cs   }]; #IO_L5P_T0_34 Sch=jd_p[1]                  
set_property -dict { PACKAGE_PIN T15  IOSTANDARD LVCMOS33  } [get_ports { sniff_spi_mosi }]; #IO_L5N_T0_34 Sch=jd_n[1]				 
set_property -dict { PACKAGE_PIN P14  IOSTANDARD LVCMOS33  } [get_ports { sniff_spi_miso }]; #IO_L6P_T0_34 Sch=jd_p[2]                  
set_property -dict { PACKAGE_PIN R14  IOSTANDARD LVCMOS33  } [get_ports { sniff_spi_clk }]; #IO_L6N_T0_VREF_34 Sch=jd_n[2]             
#set_property -dict { PACKAGE_PIN U14  IOSTANDARD LVCMOS33  } [get_ports { CS_sniffer   }]; #IO_L11P_T1_SRCC_34 Sch=jd_p[3]            
#set_property -dict { PACKAGE_PIN U15  IOSTANDARD LVCMOS33  } [get_ports { MOSI_sniffer }]; #IO_L11N_T1_SRCC_34 Sch=jd_n[3]            
#set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33  } [get_ports { MISO_sniffer }]; #IO_L21P_T3_DQS_34 Sch=jd_p[4]             
#set_property -dict { PACKAGE_PIN V18  IOSTANDARD LVCMOS33  } [get_ports { SCLK_sniffer }]; #IO_L21N_T3_DQS_34 Sch=jd_n[4]
  

