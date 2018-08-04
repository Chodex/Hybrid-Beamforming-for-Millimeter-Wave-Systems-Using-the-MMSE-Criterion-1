function [V_D,V_RF,W_D,W_RF,MSE,n] = UGEini(N_s,N_RF,H,Vn,W_opt)
 n = 1;   %number of iteration
 MSE =zeros(1,11);
 %initialization
 W_RF = 1;


 [N_r,N_t] = size(H);
 W_opt = exp( 1i*unifrnd(0,2*pi,N_r,N_s) ); 
 W_D = W_opt; 
 tw = trace(W_D'*(W_RF)'*W_RF*W_D);
 V_RF = exp( 1i*unifrnd(0,2*pi,N_t,N_RF) );
 while(n<3 || (MSE(n-2)-MSE(n-1))>1e-4 &&n<=10)
     H_u = H'*W_RF*W_D;          %effective downlink channel   
     Vn1 = tw*Vn;
     [V_RF,V_D] = TransGE (N_RF,H_u,Vn1,V_RF);
     tv = trace(V_RF*(V_D)*V_D'*V_RF');     
     %%UEside
     H_d = H*V_RF*V_D;
     Vn2 = tv*Vn;
     [W_RF,W_D] = TransGE (N_RF,H_d,Vn2,W_RF); %the same formulation
     He = W_D'*W_RF'*H*V_RF*V_D;
     tw = trace(W_D'*(W_RF)'*W_RF*W_D);
     MSE(n) = trace(He * He'- He- He'+ eye(N_s)) + Vn2*tw;
     n = n + 1;     
 end
       V_D = V_D/sqrt(tv);
       W_D = W_D*sqrt(tv);