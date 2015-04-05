library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity keyboard_binary is
    port(
        keyval1, keyval2, keyval3: in std_logic_vector(7 downto 0);
        bin: out std_logic_vector(7 downto 0)
    );
end keyboard_binary;

architecture keyboard_binary of keyboard_binary is
    
    signal buff: integer range 0 to 255;
    
begin
process(keyval1, keyval2, keyval3)
begin
    case keyval1 is
        when X"45" =>
            case keyval2 is
                when X"45" =>
                    case keyval3 is
                        when X"45" => buff <= 0;
                        when X"16" => buff <= 1;  
                        when X"1E" => buff <= 2;
                        when X"26" => buff <= 3;
                        when X"25" => buff <= 4;
                        when X"2E" => buff <= 5;
                        when X"36" => buff <= 6;
                        when X"3D" => buff <= 7;
                        when X"3E" => buff <= 8;
                        when X"46" => buff <= 9;
                        when others => buff <= 0;
                    end case;  
                    
                when X"16" =>   
                    case keyval3 is
                        when X"45" => buff <= 10;    
                        when X"16" => buff <= 11;   
                        when X"1E" => buff <= 12;
                        when X"26" => buff <= 13;
                        when X"25" => buff <= 14;
                        when X"2E" => buff <= 15;
                        when X"36" => buff <= 16;
                        when X"3D" => buff <= 17;
                        when X"3E" => buff <= 18;
                        when X"46" => buff <= 19;
                        when others => buff <= 0;
                    end case;  
                    
                when X"1E" =>
                    case keyval3 is
                        when X"45" => buff <= 20;    
                        when X"16" => buff <= 21;   
                        when X"1E" => buff <= 22;
                        when X"26" => buff <= 23;
                        when X"25" => buff <= 24;
                        when X"2E" => buff <= 25;
                        when X"36" => buff <= 26;
                        when X"3D" => buff <= 27;
                        when X"3E" => buff <= 28;
                        when X"46" => buff <= 29;
                        when others => buff <= 0;
                    end case;  
                    
                when X"26" =>
                    case keyval3 is
                        when X"45" => buff <= 30;
                        when X"16" => buff <= 31;   
                        when X"1E" => buff <= 32;
                        when X"26" => buff <= 33;
                        when X"25" => buff <= 34;
                        when X"2E" => buff <= 35;
                        when X"36" => buff <= 36;
                        when X"3D" => buff <= 37;
                        when X"3E" => buff <= 38;
                        when X"46" => buff <= 39;
                        when others => buff <= 0;
                    end case;  
                    
                when X"25" =>
                    case keyval3 is
                        when X"45" => buff <= 40;    
                        when X"16" => buff <= 41;   
                        when X"1E" => buff <= 42;
                        when X"26" => buff <= 43;
                        when X"25" => buff <= 44;
                        when X"2E" => buff <= 45;
                        when X"36" => buff <= 46;
                        when X"3D" => buff <= 47;
                        when X"3E" => buff <= 48;
                        when X"46" => buff <= 49;
                        when others => buff <= 0;
                    end case;  
                    
                when X"2E" =>
                    case keyval3 is
                        when X"45" => buff <= 50;    
                        when X"16" => buff <= 51;   
                        when X"1E" => buff <= 52;
                        when X"26" => buff <= 53;
                        when X"25" => buff <= 54;
                        when X"2E" => buff <= 55;
                        when X"36" => buff <= 56;
                        when X"3D" => buff <= 57;
                        when X"3E" => buff <= 58;
                        when X"46" => buff <= 59;
                        when others => buff <= 0;
                    end case;  
                    
                when X"36" =>
                    case keyval3 is
                        when X"45" => buff <= 60;    
                        when X"16" => buff <= 61;   
                        when X"1E" => buff <= 62;
                        when X"26" => buff <= 63;
                        when X"25" => buff <= 64;
                        when X"2E" => buff <= 65;
                        when X"36" => buff <= 66;
                        when X"3D" => buff <= 67;
                        when X"3E" => buff <= 68;
                        when X"46" => buff <= 69;
                        when others => buff <= 0;
                    end case;  
                    
                when X"3D" =>
                    case keyval3 is
                        when X"45" => buff <= 70;    
                        when X"16" => buff <= 71;   
                        when X"1E" => buff <= 72;
                        when X"26" => buff <= 73;
                        when X"25" => buff <= 74;
                        when X"2E" => buff <= 75;
                        when X"36" => buff <= 76;
                        when X"3D" => buff <= 77;
                        when X"3E" => buff <= 78;
                        when X"46" => buff <= 79;
                        when others => buff <= 0;
                    end case;  
                    
                when X"3E" =>
                    case keyval3 is
                        when X"45" => buff <= 80;    
                        when X"16" => buff <= 81;   
                        when X"1E" => buff <= 82;
                        when X"26" => buff <= 83;
                        when X"25" => buff <= 84;
                        when X"2E" => buff <= 85;
                        when X"36" => buff <= 86;
                        when X"3D" => buff <= 87;
                        when X"3E" => buff <= 88;
                        when X"46" => buff <= 89;
                        when others => buff <= 0;
                    end case;  
                    
                when X"46" =>
                    case keyval3 is
                        when X"45" => buff <= 90;    
                        when X"16" => buff <= 91;   
                        when X"1E" => buff <= 92;
                        when X"26" => buff <= 93;
                        when X"25" => buff <= 94;
                        when X"2E" => buff <= 95;
                        when X"36" => buff <= 96;
                        when X"3D" => buff <= 97;
                        when X"3E" => buff <= 98;
                        when X"46" => buff <= 99;
                        when others => buff <= 0;
                    end case; 
				when others => buff <= 0;		  
            end case;
              
        when X"16" =>   
        
            case keyval2 is
                when X"45" =>
                    case keyval3 is
                        when X"45" => buff <= 100;    
                        when X"16" => buff <= 101;   
                        when X"1E" => buff <= 102;
                        when X"26" => buff <= 103;
                        when X"25" => buff <= 104;
                        when X"2E" => buff <= 105;
                        when X"36" => buff <= 106;
                        when X"3D" => buff <= 107;
                        when X"3E" => buff <= 108;
                        when X"46" => buff <= 109;
                        when others => buff <= 0;
                    end case;  
                    
                when X"16" =>   
                    case keyval3 is
                        when X"45" => buff <= 110;    
                        when X"16" => buff <= 111;   
                        when X"1E" => buff <= 112;
                        when X"26" => buff <= 113;
                        when X"25" => buff <= 114;
                        when X"2E" => buff <= 115;
                        when X"36" => buff <= 116;
                        when X"3D" => buff <= 117;
                        when X"3E" => buff <= 118;
                        when X"46" => buff <= 119;
                        when others => buff <= 0;
                    end case;  
                    
                when X"1E" =>
                    case keyval3 is
                        when X"45" => buff <= 120;    
                        when X"16" => buff <= 121;   
                        when X"1E" => buff <= 122;
                        when X"26" => buff <= 123;
                        when X"25" => buff <= 124;
                        when X"2E" => buff <= 125;
                        when X"36" => buff <= 126;
                        when X"3D" => buff <= 127;
                        when X"3E" => buff <= 128;
                        when X"46" => buff <= 129;
                        when others => buff <= 0;
                    end case;  
                    
                when X"26" =>
                    case keyval3 is
                        when X"45" => buff <= 130;    
                        when X"16" => buff <= 131;   
                        when X"1E" => buff <= 132;
                        when X"26" => buff <= 133;
                        when X"25" => buff <= 134;
                        when X"2E" => buff <= 135;
                        when X"36" => buff <= 136;
                        when X"3D" => buff <= 137;
                        when X"3E" => buff <= 138;
                        when X"46" => buff <= 139;
                        when others => buff <= 0;
                    end case;  
                    
                when X"25" =>
                    case keyval3 is
                        when X"45" => buff <= 140;    
                        when X"16" => buff <= 141;   
                        when X"1E" => buff <= 142;
                        when X"26" => buff <= 143;
                        when X"25" => buff <= 144;
                        when X"2E" => buff <= 145;
                        when X"36" => buff <= 146;
                        when X"3D" => buff <= 147;
                        when X"3E" => buff <= 148;
                        when X"46" => buff <= 149;
                        when others => buff <= 0;
                    end case;  
                    
                when X"2E" =>
                    case keyval3 is
                        when X"45" => buff <= 150;    
                        when X"16" => buff <= 151;   
                        when X"1E" => buff <= 152;
                        when X"26" => buff <= 153;
                        when X"25" => buff <= 154;
                        when X"2E" => buff <= 155;
                        when X"36" => buff <= 156;
                        when X"3D" => buff <= 157;
                        when X"3E" => buff <= 158;
                        when X"46" => buff <= 159;
                        when others => buff <= 0;
                    end case;  
                    
                when X"36" =>
                    case keyval3 is
                        when X"45" => buff <= 160;    
                        when X"16" => buff <= 161;   
                        when X"1E" => buff <= 162;
                        when X"26" => buff <= 163;
                        when X"25" => buff <= 164;
                        when X"2E" => buff <= 165;
                        when X"36" => buff <= 166;
                        when X"3D" => buff <= 167;
                        when X"3E" => buff <= 168;
                        when X"46" => buff <= 169;
                        when others => buff <= 0;
                    end case;  
                    
                when X"3D" =>
                    case keyval3 is
                        when X"45" => buff <= 170;    
                        when X"16" => buff <= 171;   
                        when X"1E" => buff <= 172;
                        when X"26" => buff <= 173;
                        when X"25" => buff <= 174;
                        when X"2E" => buff <= 175;
                        when X"36" => buff <= 176;
                        when X"3D" => buff <= 177;
                        when X"3E" => buff <= 178;
                        when X"46" => buff <= 179;
                        when others => buff <= 0;
                    end case;  
                    
                when X"3E" =>
                    case keyval3 is
                        when X"45" => buff <= 180;    
                        when X"16" => buff <= 181;   
                        when X"1E" => buff <= 182;
                        when X"26" => buff <= 183;
                        when X"25" => buff <= 184;
                        when X"2E" => buff <= 185;
                        when X"36" => buff <= 186;
                        when X"3D" => buff <= 187;
                        when X"3E" => buff <= 188;
                        when X"46" => buff <= 189;
                        when others => buff <= 0;
                    end case;  
                    
                when X"46" =>
                    case keyval3 is
                        when X"45" => buff <= 190;    
                        when X"16" => buff <= 191;   
                        when X"1E" => buff <= 192;
                        when X"26" => buff <= 193;
                        when X"25" => buff <= 194;
                        when X"2E" => buff <= 195;
                        when X"36" => buff <= 196;
                        when X"3D" => buff <= 197;
                        when X"3E" => buff <= 198;
                        when X"46" => buff <= 199;
                        when others => buff <= 0;
                    end case;  
                when others => buff <= 0;
            end case;
            
        when X"1E" =>
            case keyval2 is
                when X"45" =>
                    case keyval3 is
                        when X"45" => buff <= 200;    
                        when X"16" => buff <= 201;   
                        when X"1E" => buff <= 202;
                        when X"26" => buff <= 203;
                        when X"25" => buff <= 204;
                        when X"2E" => buff <= 205;
                        when X"36" => buff <= 206;
                        when X"3D" => buff <= 207;
                        when X"3E" => buff <= 208;
                        when X"46" => buff <= 209;
                        when others => buff <= 0;
                    end case;  
                    
                when X"16" =>   
                    case keyval3 is
                        when X"45" => buff <= 210;    
                        when X"16" => buff <= 211;   
                        when X"1E" => buff <= 212;
                        when X"26" => buff <= 213;
                        when X"25" => buff <= 214;
                        when X"2E" => buff <= 215;
                        when X"36" => buff <= 216;
                        when X"3D" => buff <= 217;
                        when X"3E" => buff <= 218;
                        when X"46" => buff <= 219;
                        when others => buff <= 0;
                    end case;  
                    
                when X"1E" =>
                    case keyval3 is
                        when X"45" => buff <= 220;    
                        when X"16" => buff <= 221;   
                        when X"1E" => buff <= 222;
                        when X"26" => buff <= 223;
                        when X"25" => buff <= 224;
                        when X"2E" => buff <= 225;
                        when X"36" => buff <= 226;
                        when X"3D" => buff <= 227;
                        when X"3E" => buff <= 228;
                        when X"46" => buff <= 229;
                       when others => buff <= 0;
                    end case;  
                    
                when X"26" =>
                    case keyval3 is
                        when X"45" => buff <= 230;    
                        when X"16" => buff <= 231;   
                        when X"1E" => buff <= 232;
                        when X"26" => buff <= 233;
                        when X"25" => buff <= 234;
                        when X"2E" => buff <= 235;
                        when X"36" => buff <= 236;
                        when X"3D" => buff <= 237;
                        when X"3E" => buff <= 238;
                        when X"46" => buff <= 239;
                        when others => buff <= 0;
                    end case;  
                    
                when X"25" =>
                    case keyval3 is
                        when X"45" => buff <= 240;    
                        when X"16" => buff <= 241;   
                        when X"1E" => buff <= 242;
                        when X"26" => buff <= 243;
                        when X"25" => buff <= 244;
                        when X"2E" => buff <= 245;
                        when X"36" => buff <= 246;
                        when X"3D" => buff <= 247;
                        when X"3E" => buff <= 248;
                        when X"46" => buff <= 249;
                        when others => buff <= 0;
                    end case;  
                    
                when X"2E" =>
                    case keyval3 is
                        when X"45" => buff <= 250;    
                        when X"16" => buff <= 251;   
                        when X"1E" => buff <= 252;
                        when X"26" => buff <= 253;
                        when X"25" => buff <= 254;
                        when X"2E" => buff <= 255;
                        when others => buff <= 0;
                    end case;  
                    
                when others => buff <= 0;
            end case;
            
        when others => buff <= 0;
        
    end case;
end process;
    bin <= conv_std_logic_vector(buff, 8);
end keyboard_binary;