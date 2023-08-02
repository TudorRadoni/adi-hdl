
# 1. Update the signals names for both JC and JD PMOD connectors

##Pmod Header JC   ADC PMOD CONNECTOR

set_property -dict { PACKAGE_PIN V15  IOSTANDARD LVCMOS33 } [get_ports { SPI_CS   }]; #IO_L10P_T1_34 Sch=jc_p[1]   			 
set_property -dict { PACKAGE_PIN W15  IOSTANDARD LVCMOS33 } [get_ports { SPI_MOSI }]; #IO_L10N_T1_34 Sch=jc_n[1]		     
set_property -dict { PACKAGE_PIN T11  IOSTANDARD LVCMOS33 } [get_ports { SPI_MISO }]; #IO_L1P_T0_34 Sch=jc_p[2]              
set_property -dict { PACKAGE_PIN T10  IOSTANDARD LVCMOS33 } [get_ports { SPI_SCLK }]; #IO_L1N_T0_34 Sch=jc_n[2]              
                                                                                                                                                                                                                                                           
##Pmod Header JD   SNIFFING PMOD CONNECTOR

set_property -dict { PACKAGE_PIN T14  IOSTANDARD LVCMOS33  } [get_ports { SPI_CS_SCOPY }]; #IO_L5P_T0_34 Sch=jd_p[1]                  
set_property -dict { PACKAGE_PIN T15  IOSTANDARD LVCMOS33  } [get_ports { SPI_MOSI_SCOPY }]; #IO_L5N_T0_34 Sch=jd_n[1]				 
set_property -dict { PACKAGE_PIN P14  IOSTANDARD LVCMOS33  } [get_ports { SPI_MISO_SCOPY }]; #IO_L6P_T0_34 Sch=jd_p[2]                  
set_property -dict { PACKAGE_PIN R14  IOSTANDARD LVCMOS33  } [get_ports { SPI_SCLK_SCOPY }]; #IO_L6N_T0_VREF_34 Sch=jd_n[2]                
