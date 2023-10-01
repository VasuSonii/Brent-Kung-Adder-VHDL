library IEEE;
use IEEE.std_logic_1164.all;

entity brentkung is
	port(
		a,b: in std_logic_vector(15 downto 0);
		y: out std_logic_vector(15 downto 0);
		cout: out std_logic;
		cin: in std_logic
	);
end entity;

architecture struct of brentkung is
	signal p1,g1: std_logic_vector(15 downto 0);
	signal p2, g2: std_logic_vector(7 downto 0);
	signal p3,g3: std_logic_vector(3 downto 0);
	signal p4,g4: std_logic_vector(1 downto 0);
	signal p5,g5: std_logic;
	signal c: std_logic_vector(16 downto 0);
    component andgate is
        port (A, B: in std_logic;
        O: out std_logic);
    end component andgate;

    component xorgate is
        port (A, B: in std_logic;
        O: out std_logic);
    end component xorgate;

    component abcgate is
        port (A, B, C: in std_logic;
        O: out std_logic);
    end component abcgate;

    component Cin_map_G is
        port(A, B, Cin: in std_logic;
        O: out std_logic);
    end component Cin_map_G;
begin
	L1: for i in 0 to 15 generate
	xor_i :	xorgate port map(a => a(i), b => b(i), O=>p1(i));
	end generate L1;

	L2: for i in 1 to 15 generate
	and_i :	andgate port map(a=>a(i), b=>b(i), O=>g1(i));
	end generate L2;
			
	cmapg1 : Cin_map_G port map(a=>a(0), b=>b(0), cin=> cin, O=>g1(0));
	c(1) <= g1(0);

	--Declaring the remaining G, P for the tree level 2
	abc1 : abcgate port map(a=>g1(1), b=> p1(1), c=>g1(0), O=> g2(0));
	abc2 : abcgate port map(a=>g1(3), b=> p1(3), c=>g1(2), O=> g2(1));
	abc3 : abcgate port map(a=>g1(5), b=> p1(5), c=>g1(4), O=> g2(2));
	abc4 : abcgate port map(a=>g1(7), b=> p1(7), c=>g1(6), O=> g2(3));
	abc5 : abcgate port map(a=>g1(9), b=> p1(9), c=>g1(8), O=> g2(4));
	abc6 : abcgate port map(a=>g1(11), b=> p1(11), c=>g1(10), O=> g2(5));
	abc7 : abcgate port map(a=>g1(13), b=> p1(13), c=>g1(12), O=> g2(6));
	abc8 : abcgate port map(a=>g1(15), b=> p1(15), c=>g1(14), O=> g2(7));

	and1 : andgate port map(a=>p1(1), b=>p1(0), O=>p2(0));
	and2 : andgate port map(a=>p1(3), b=>p1(2), O=>p2(1));
	and3 : andgate port map(a=>p1(5), b=>p1(4), O=>p2(2));
	and4 : andgate port map(a=>p1(7), b=>p1(6), O=>p2(3));
	and5 : andgate port map(a=>p1(9), b=>p1(8), O=>p2(4));
	and6 : andgate port map(a=>p1(11), b=>p1(10), O=>p2(5));
	and7 : andgate port map(a=>p1(13), b=>p1(12), O=>p2(6));
	and8 : andgate port map(a=>p1(15), b=>p1(14), O=>p2(7));
	--Declaring G, P for the level 3
	abc9 : abcgate port map(a=>g2(1), b=>p2(1), c=>g2(0), O=>g3(0));
	abc10 : abcgate port map(a=>g2(3), b=>p2(3), c=>g2(2), O=>g3(1));
	abc11 : abcgate port map(a=>g2(5), b=>p2(5), c=>g2(4), O=>g3(2));
	abc12 : abcgate port map(a=>g2(7), b=>p2(7), c=>g2(6), O=>g3(3));

	and9 : andgate port map(a=>p2(1), b=>p2(0), O=>p3(0));
	and10 : andgate port map(a=>p2(3), b=>p2(2), O=>p3(1));
	and11 : andgate port map(a=>p2(5), b=>p2(4), O=>p3(2));
	and12 : andgate port map(a=>p2(7), b=>p2(6), O=>p3(3));
	--Declaring G,P for level 4
	abc13 : abcgate port map(a=>g3(1), b=>p3(1),c=>g3(0), O=>g4(0));
	abc14 : abcgate port map(a=>g3(3), b=>p3(3),c=>g3(2), O=>g4(1));

	and13 : andgate port map(a=>p3(1), b=>p3(0),O=>p4(0));
	and14 : andgate port map(a=>p3(3), b=>p3(2),O=>p4(1));
	--Declaring G,P for the final level
	abc15 : abcgate port map(a=>g4(1), b=>p4(1), c=>g4(0), O=>g5);

	and15 : andgate port map(a=>p4(1), b=>p4(0), O=>p5);
	--Declaring Carry for the adder C2-C15
	abc_C2: abcgate port map(a=>g2(0), b=>p2(0), c=>cin ,O=>c(2));
	abc_C3: abcgate port map(a=>g1(2), b=>p1(2), c=>c(2) ,O=>c(3));
	abc_C4: abcgate port map(a=>g3(0) , b=>p3(0) , c=>cin ,O=>c(4));
	abc_C5: abcgate port map(a=>g1(4) , b=>p1(4) , c=>c(4) ,O=>c(5));
	abc_C6: abcgate port map(a=>g2(2) , b=>p2(2) , c=>c(4) ,O=>c(6));
	abc_C7: abcgate port map(a=>g1(6) , b=>p1(6) , c=>c(6) ,O=>c(7));
	abc_C8: abcgate port map(a=>g4(0) , b=>p4(0) , c=>cin ,O=>c(8));
	abc_C9: abcgate port map(a=>g1(8) , b=>p1(8) , c=>c(8) ,O=>c(9));
	abc_C10: abcgate port map(a=>g2(4) , b=>p2(4) , c=>c(8) ,O=>c(10));
	abc_C11: abcgate port map(a=>g1(10) , b=>p1(10) , c=>c(10) ,O=>c(11));
	abc_C12: abcgate port map(a=>g3(2) , b=>p3(2) , c=>c(8) ,O=>c(12));
	abc_C13: abcgate port map(a=>g1(12) , b=>p1(12) , c=>c(12) ,O=>c(13));
	abc_C14: abcgate port map(a=>g2(6) , b=>p2(6) , c=>c(12) ,O=>c(14));
	abc_C15: abcgate port map(a=>g1(14) , b=>p1(14) , c=>c(14) ,O=>c(15));	
	abc_C16: abcgate port map(a=>g5 , b=>p5 , c=>cin ,O=>c(16));

	--sum signals
	L4 : for i in 0 to 15 generate
		sumxors_i : xorgate port map(a=> p1(i), b=> c(i), O=> y(i));
	end generate L4;

	c(0) <= cin;
	cout <= c(16);

end struct;
