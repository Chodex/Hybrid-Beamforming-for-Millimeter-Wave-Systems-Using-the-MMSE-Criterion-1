function  mytoc(N_LOOP,t1)
t2 = clock;
myt=etime(t2,t1) ;
mym=fix(myt/60);
mys=myt-60*mym;
wholetime = N_LOOP/10*myt ;
wholeh=fix(wholetime/3600);
wholem=fix((wholetime-3600*wholeh)/60);
wholes=wholetime-wholeh*3600-wholem*60;
disp(['ִ��10��ѭ������ʱ��Ϊ��',num2str(mym),'��',num2str(mys),'��']);
disp(['����������ʱ��Ϊ��',num2str(wholeh) 'Сʱ',num2str(wholem),'��',num2str(wholes),'��']);
