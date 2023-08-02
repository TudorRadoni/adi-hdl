# 1. create pwm_led_0, pwm_led_1, pwm_led_2, pwm_led_3 ports
    # command example: create_bd_port -dir O example led
   
   create_bd_port -dir O pwm_led_0
   create_bd_port -dir O pwm_led_1
   create_bd_port -dir O pwm_led_2
   create_bd_port -dir O pwm_led_3

# 2. add axi_pwm_custom IP using ad_ip_instance command

   ad_ip_instance axi_pwm_custom axi_pwm_led_generator

# 3. connect the axi_pwm_custom IP to the block design ports using ad_connect command
   
   ad_connect axi_pwm_led_generator/pwm_led_0 pwm_led_0
   ad_connect axi_pwm_led_generator/pwm_led_1 pwm_led_1
   ad_connect axi_pwm_led_generator/pwm_led_2 pwm_led_2
   ad_connect axi_pwm_led_generator/pwm_led_3 pwm_led_3

# 4. connect the axi_pwm_custom IP to the CPU using ad_cpu_interconnect at 0x44a00000

   ad_cpu_interconnect 0x44a00000 axi_pwm_led_generator
   