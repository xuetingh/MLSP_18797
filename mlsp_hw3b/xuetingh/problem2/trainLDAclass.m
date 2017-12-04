function [V,ml] = trainLDAclass(T,num)
% input T: data
% input num: number of classes
% output V: LDA matrix
% output ml: model for all classes
w = zeros(1,600);
wl = zeros(num,600);
total = 0;
for i = 1:num
    total = total + size(T{1,i}, 1);
    for j = 1: size(T{1,i}, 1)
        wl(i,:) = wl(i,:) + T{1,i}(j,:);
    end
    w = w + wl(i,:);
    wl(i,:) = wl(i,:)/size(T{1,i}, 1);
end
w = w / total;

Sb = zeros(600,600);
Sw = zeros(600,600);
for i = 1:num
    Sb = Sb + size(T{1,i}, 1)*(wl(i,:) - w)' * (wl(i,:) - w);
    for j = 1: size(T{1,i}, 1)
        Sw = Sw + (T{1,i}(j,:) - wl(i,:))' * (T{1,i}(j,:) - wl(i,:));
    end
end
[V,~] = eigs(Sb,Sw,num-1);

ml = zeros(23,24);
for i = 1:num
    for j = 1: size(T{1,i}, 1)
        ml(:,i) = ml(:,i) + normc(V'*T{1,i}(j,:)');
    end
    ml(:,i) = ml(:,i)/size(T{1,i}, 1);
    ml(:,i) = normc(ml(:,i));
end