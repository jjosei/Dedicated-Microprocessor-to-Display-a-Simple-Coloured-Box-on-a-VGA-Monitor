----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:50:17 09/26/2023 
-- Design Name: 
-- Module Name:    V_FSM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




entity V_FSM is port(
  CLK, RESET : IN STD_LOGIC;
  VDataon, VSync : OUT STD_LOGIC);
end V_FSM;


architecture Behavioral of V_FSM is
  type state is (V_P, V_Q, V_R, V_S);
  signal PS,NS : state;
  signal vcntcurr, vcntnext : std_logic_vector(10 downto 0);
begin
   process(CLK,RESET)
	  begin
	    
		   if(reset='1')then
			   PS <= V_P;
				vcntcurr <= "00000000000";
		   elsif (rising_edge(CLK))then
            PS <= NS;
            vcntcurr <= vcntnext;
				
         end if;
		 	
   end process;



   process(PS,vcntcurr)
   begin
     case (PS) is
       when V_P =>
          vcntnext <= vcntcurr + "00000000001";
          VDataon <= '0';
          VSync <= '0';
          if(vcntcurr = "00000000010")then
             NS <= V_Q;
             
          else
             NS <= PS;
          end if;
			 
			 
		 when V_Q =>
          vcntnext <= vcntcurr + "00000000001";
          VDataon <= '0';
          VSync <= '1';
          if(vcntcurr = "00000100010")then
             NS <= V_R;
            
          else
             NS <= PS;
          end if;	 


       when V_R =>
          vcntnext <= vcntcurr + "00000000001";
          VDataon <= '1';
          VSync <= '1';
          if(vcntcurr = "01000000010")then
             NS <= V_S;
            
          else
             NS <= PS;
          end if;
			 
       when V_S =>
         
          VDataon <= '0';
          VSync <= '1';
          if(vcntcurr = "01000010000")then
             NS <= V_P;
             vcntnext <= (others => '0');
          else
			     vcntnext <= vcntcurr + "00000000001";
             NS <= PS;
          end if;
			 
	end case;
  end process;	
 
 
end Behavioral;


