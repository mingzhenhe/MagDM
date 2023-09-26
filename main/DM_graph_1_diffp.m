plist=[1 0.6 0 -0.6 -1];
Draw_plane = figure(1);
set(Draw_plane,'Position',[0,0,750,800])

yunit = 0.155666666666667;
for pind = 1:length(plist)
    P_reverse = -0.5*plist(pind)+0.5;
    draw_p(plist, pind);
    annotation(Draw_plane,'textbox',...
    [0.026 1-yunit-0.17*(pind-1) 0.0617777777777778 0.0341666666666667],...
    'String',{['P=',num2str(P_reverse)]},'EdgeColor',"none");
end

