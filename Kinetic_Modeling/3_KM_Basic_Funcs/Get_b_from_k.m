function b=Get_b_from_k(k, Size_Beds)

for b=1:1:size(Size_Beds,1)
    index(b)=Size_Beds{b,1}(1,3);
end
csum=cumsum(index);

Num_Beds=size(Size_Beds,1);

% Max.  allowable # of Beds: 10
switch Num_Beds
    case 1
        if k <= csum(1)
            b=1;
        end
    case 2
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
    case 3
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
    case 4
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
    case 5
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
        if k > csum(4) && k <= csum(5)
            b=5;
        end
    case 6
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
        if k > csum(4) && k <= csum(5)
            b=5;
        end
        if k > csum(5) && k <= csum(6)
            b=6;
        end
    case 7
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
        if k > csum(4) && k <= csum(5)
            b=5;
        end
        if k > csum(5) && k <= csum(6)
            b=6;
        end
        if k > csum(6) && k <= csum(7)
            b=7;
        end
    case 8
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
        if k > csum(4) && k <= csum(5)
            b=5;
        end
        if k > csum(5) && k <= csum(6)
            b=6;
        end
        if k > csum(6) && k <= csum(7)
            b=7;
        end
        if k > csum(7) && k <= csum(8)
            b=8;
        end
    case 9
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
        if k > csum(4) && k <= csum(5)
            b=5;
        end
        if k > csum(5) && k <= csum(6)
            b=6;
        end
        if k > csum(6) && k <= csum(7)
            b=7;
        end
        if k > csum(7) && k <= csum(8)
            b=8;
        end
        if k > csum(8) && k <= csum(9)
            b=9;
        end
    case 10
        if k <= csum(1)
            b=1;
        end
        if k > csum(1) && k <= csum(2)
            b=2;
        end
        if k > csum(2) && k <= csum(3)
            b=3;
        end
        if k > csum(3) && k <= csum(4)
            b=4;
        end
        if k > csum(4) && k <= csum(5)
            b=5;
        end
        if k > csum(5) && k <= csum(6)
            b=6;
        end
        if k > csum(6) && k <= csum(7)
            b=7;
        end
        if k > csum(7) && k <= csum(8)
            b=8;
        end
        if k > csum(8) && k <= csum(9)
            b=9;
        end
        if k > csum(9) && k <= csum(10)
            b=10;
        end
end




end