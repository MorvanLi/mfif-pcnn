function Mp = Focus_Measure(I)
    xj = padarray(I,[1 1],'symmetric');
    EOL = conv2(xj,[1  4  1;4 -20 4;1  4  1]./6,'valid');
    E_2 = EOL.*EOL;
    FM = conv2(E_2,ones(8),'valid');
    Mp = FM(1:8:end,1:8:end);
end
