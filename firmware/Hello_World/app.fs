: multiplicar		\ utiliza peripheral_mult.v
multi_a !
multi_b !
d# 1 multi_init !
d# 1 multi_init !
begin multi_done @ d# 1 = until \ espera hasta que la señal done del multiplicador este en 1
multi_pp_high @
multi_pp_low @

;

: dividir		 \ utiliza peripheral_div.v
swap div_a !
div_b !
d# 1 div_init !
begin div_done @ d# 1 = until \ espera hasta que la señal done del divisor este en 1
div_c @
\ d# 3 + div_a !
;

: main 

d# 10  
d# 5 
d# 2
-
+
d# 2
dividir  
d# 2
multiplicar
emit-uart
  
;








