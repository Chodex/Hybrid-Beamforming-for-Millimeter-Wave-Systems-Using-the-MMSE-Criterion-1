function [ H,W_codebook,F_codebook ] = ChannelULA( N_r,N_t,N_u,L )
%  ULA�ŵ�����
%  �Ա����������뱾
H = zeros(N_r, N_t,N_u);                 %�ŵ�
H_path = zeros(N_r, N_t,L);
W_codebook = zeros(N_r,L,N_u);         %�û���RF�뱾
F_codebook = zeros(N_t,L,N_u);         %��վ��RF�뱾
for r = 1:N_r
    %-----------AOA MS
    aoa = 2*pi* rand(N_u,L);          %���ӣ�0,2*pi���ľ��ȷֲ�
    aoa = sin(aoa);
    %-----------AOD BS
    aod = 2*pi* rand(N_u, L);         %���ӣ�0,2*pi���ľ��ȷֲ�
    aod = sin(aod);
    %-----------Complex path gain
    alpha = complex(randn(N_u,L),randn(N_u,L))/sqrt(2);
    
    signature_t = [0:(N_t-1)]';
    signature_t = 1i*pi* signature_t;               %Ϊ��������signature������׼��
    signature_r = [0:(N_r-1)]';
    signature_r = 1i*pi* signature_r;               %Ϊ��������signature������׼��

    for K_i = 1:N_u
        for L_i= 1: L
            H_path(:,:,L_i)=alpha(K_i,L_i)*exp(aoa(K_i,L_i)*signature_r)*exp(aod(K_i,L_i)*signature_t)';
            W_codebook(:,L_i,K_i) = exp(aoa(K_i,L_i)*signature_r);
            F_codebook(:,L_i,K_i) = exp(aod(K_i,L_i)*signature_t);
        end
        H(:,:,K_i) = sqrt(N_t*N_r/L)*sum(H_path,3);
    end
end

end

