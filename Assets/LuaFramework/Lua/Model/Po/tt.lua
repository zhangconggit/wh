
	CardList = 
{
	PT = --∆’Õ®ª∞
	{
		color_1_01 = 'g_1tong',color_1_04 = 'g_4tong',color_1_07 = 'g_7tong',
		color_1_02 = 'g_2tong',color_1_05 = 'g_5tong',color_1_08 = 'g_8tong',
		color_1_03 = 'g_3tong',color_1_06 = 'g_6tong',color_1_09 = 'g_9tong',
		
		color_2_01 = 'g_1tiao',color_2_04 = 'g_1tiao',color_2_07 = 'g_1tiao',
		color_2_02 = 'g_1tiao',color_2_05 = 'g_1tiao',color_2_08 = 'g_1tiao',
		color_2_03 = 'g_1tiao',color_2_06 = 'g_1tiao',color_2_09 = 'g_1tiao',
		
		color_3_01 = 'g_1wan',color_3_04 = 'g_4wan',color_3_07 = 'g_7wan',
		color_3_02 = 'g_2wan',color_3_05 = 'g_5wan',color_3_08 = 'g_8wan',
		color_3_03 = 'g_3wan',color_3_06 = 'g_6wan',color_3_09 = 'g_9wan',
		
		color_4_10 = 'g_dongfeng',color_4_11 = 'g_xifeng',color_4_12 = 'g_nanfeng',
		color_4_13 = 'g_beifeng',color_4_14 = 'g_hongzhong',color_4_10 = 'g_fa',
		color_4_10 = 'g_bai',
		
		peng = 'g_peng', gang = 'g_gang', hu = 'g_hu', zimo = 'g_hu_zimo'
	},

	FY = --∑Ω—‘
	{
		color_1_01 = {'b1_001','b1_002','b1_003','b1_004'},color_1_04 = {'b4_001','b4_002','b4_003'},color_1_07 = {'b7_001','b7_002','b7_003'},
		color_1_02 = {'b2_001','b2_002','b2_003','b2_004'},color_1_05 = {'b5_001','b5_002','b5_003'},color_1_08 = {'b8_001','b8_002','b8_003'},
		color_1_03 = {'b3_001','b3_002','b3_003','b3_004'},color_1_06 = {'b6_001','b6_002'},		 color_1_09 = {'b9_001','b9_002','b9_003'},
		
		color_2_01 = {'t1_001','t1_002'},color_2_04 = {'t4_001','t4_002','t4_003'}, color_2_07 =  {'t7'},
		color_2_02 = {'t2_001','t2_002'},color_2_05 = {'t5'},						color_2_08 =  {'t8_001','t8_002'},
		color_2_03 = {'t3_001','t3_002'},color_2_06 = {'t6'},						color_2_09 =  {'t9'},
		
		color_3_01 = {'w1'},			 color_3_04 = {'w4'},color_3_07 = {'w7'},
		color_3_02 = {'w2_001','w2_002'},color_3_05 = {'w5'},color_3_08 = {'w8'},
		color_3_03 = {'w3'},			 color_3_06 = {'w6'},color_3_09 = {'w9'},
		
		color_4_10 = {'fd'},color_4_11 = {'fx'},color_4_12 = {'fn'},
		color_4_13 = {'fb_001','fb_002'},color_4_14 = {'hz_001','hz_002','hz_003'},color_4_10 = {'fc_001','fc_002'},
		color_4_10 = {'bb_001','bb_002','bb_003'},
		
		peng = {'peng'}, gang = {'gang_001','gang_002'}, hu = {}, zimo = {}
	}
}
	print(CardList.PT.color_3_01);

	math.randomseed(tostring(os.time()):reverse():sub(1, 6));
	local m = table.getn(CardList.FY.color_1_01);
	local n = 0;
	for i = 1, 10 do
		n = math.random(1,m);
		print(CardList.FY.color_1_01[n]);
	end
	

	