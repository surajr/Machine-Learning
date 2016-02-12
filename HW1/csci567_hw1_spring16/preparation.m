function [features,label] = preparation(filename)

fileID = fopen(filename);
C = textscan(fileID,'%s %s %s %s %s %s %s','delimiter',',');
fclose(fileID);

buying  = C{1};
maint   = C{2};
doors   = C{3};
persons = C{4};
lug_boot= C{5};
safety  = C{6};
new_label= C{7};

%convert category to numeric==============================
buying(strcmp('vhigh',buying))  = {'4'};
buying(strcmp('high',buying))   = {'3'};
buying(strcmp('med',buying))    = {'2'};
buying(strcmp('low',buying))    = {'1'};

maint(strcmp('vhigh',maint))  = {'4'};
maint(strcmp('high',maint))   = {'3'};
maint(strcmp('med',maint))    = {'2'};
maint(strcmp('low',maint))    = {'1'};

doors(strcmp('5more',doors))    = {'5'};

persons(strcmp('more',persons))    = {'6'};

lug_boot(strcmp('big',lug_boot))    = {'3'};
lug_boot(strcmp('med',lug_boot))    = {'2'};
lug_boot(strcmp('small',lug_boot))  = {'1'};

safety(strcmp('high',safety))   = {'3'};
safety(strcmp('med',safety))    = {'2'};
safety(strcmp('low',safety))    = {'1'};

new_label(strcmp('unacc',new_label))    = {'1'};
new_label(strcmp('acc',new_label))      = {'2'};
new_label(strcmp('good',new_label))     = {'3'};
new_label(strcmp('vgood',new_label))    = {'4'};
%end convert category to numeric==============================


%convert string to num==============================
buying      = cellfun(@str2num, buying);
maint       = cellfun(@str2num, maint);
doors       = cellfun(@str2num, doors);
persons     = cellfun(@str2num, persons);
lug_boot    = cellfun(@str2num, lug_boot);
safety      = cellfun(@str2num, safety);
new_label = cellfun(@str2num, new_label);
%end convert string to num==============================

features = horzcat(buying,maint,doors,persons,lug_boot,safety);
label = new_label;











