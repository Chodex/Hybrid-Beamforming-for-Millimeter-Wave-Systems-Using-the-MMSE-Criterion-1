function [V_RF,V_D] = TransGE (N_RF,H,Vn1,V_RF)
[N_t,N_s] = size(H);
if V_RF == 1
V_RF = exp( 1i*unifrnd(0,2*pi,N_t,N_RF) );  %randomly initialization
end
for m = 1:2          
    for j = 1:N_RF
        V_RF_tilde = V_RF;
        V_RF_tilde(:,j) =[];               %ȥ����j�е�V_RF
        Aj = 1/(Vn1*N_t)*H'*(V_RF_tilde)*V_RF_tilde'*H+eye(N_s);
        A = 1/(Vn1*N_t)*H*(Aj^(-2))*H';
        B = 1/N_t*eye(N_t)+1/(Vn1*N_t)*H*(Aj^(-1))*H';
        [V,D] = eig(A,B);
        [~,IX] = sort(diag(D),'descend'); %����ֵ��������
        eig_Vector = V(:,IX);                  %ȡ����Ӧ����ֵ����������
        V_RF(:,j) = exp(1i*angle(eig_Vector(:,1))); %�������������Ӧȡģ��ֵ
    end    
end
V_D = inv(V_RF'*H*H'*V_RF+Vn1*(V_RF)'*V_RF)*V_RF'*H;
              
 