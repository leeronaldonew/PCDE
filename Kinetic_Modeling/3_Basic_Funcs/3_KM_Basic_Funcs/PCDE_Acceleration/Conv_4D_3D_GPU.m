function [DB_3D]=Conv_4D_3D_GPU(kBq)

%% 4D array into 3D array
coder.gpu.kernelfun();
size_WB=size(kBq);
DB_3D=zeros(size_WB(1)*size_WB(2),size_WB(4),size_WB(3),'single');
for k=1:1:size_WB(3)
    for j=1:1:size_WB(2)
        for i=1:1:size_WB(1)
            for p=1:1:size_WB(4)
                DB_3D(i+size_WB(1)*(j-1),p,k)=kBq(i,j,k,p);
            end
        end
    end
end

end