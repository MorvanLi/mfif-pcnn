function Db = Majority_Filter(D,l)
    D = D - 0.5;
    w = ones(l);
    D = conv2(D, w, 'same');
    D = conv2(D, w, 'same');
    Db = D > 0;
end