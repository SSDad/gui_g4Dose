function [hMenu, hMenuItem] = addMenu(hFig_main)

%% tps
hMenu.tps = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'Menu');
                                            
hMenuItem.LoadCTImages  =   uimenu('Parent',               hMenu.tps,...
                                'Label',                'Plan (Load CT Images)',...
                                    'Checked',           'off',...
                                    'Enable',               'on', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_LoadCTImages_Callback);

hMenuItem.LoadTPSDose  =   uimenu('Parent',               hMenu.tps,...
                                'Label',                'Load/View TPS Dose',...
                                    'Checked',           'off',...
                                    'Enable',               'off', ...
                                'HandleVisibility', 'callback', ...
                                'Callback',            @hMenuItem_LoadTPSDose_Callback);
                                
hMenuItem.LoadG4Dose  =   uimenu('Parent',               hMenu.tps,...
                                    'Label',                'Load Gent4 Dose',...
                                        'Checked',           'off',...
                                        'Enable',               'off', ...
                                    'Separator',          'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_LoadG4Dose_Callback);
                                
hMenuItem.ViewG4Dose  =   uimenu('Parent',               hMenu.tps,...
                                    'Label',                'View Gent4 Dose',...
                                        'Checked',           'off',...
                                        'Enable',               'off', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_ViewG4Dose_Callback);

hMenuItem.GammaMap  =   uimenu('Parent',               hMenu.tps,...
                                    'Label',                'Gamma Map',...
                                        'Checked',           'off',...
                                        'Enable',               'off', ...
                                    'Separator',          'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_GammaMap_Callback);

hMenuItem.ISOView  =   uimenu('Parent',               hMenu.tps,...
                                    'Label',                'ISO View',...
                                        'Checked',           'off',...
                                        'Enable',               'on', ...
                                    'Separator',          'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_ISOView_Callback);
                                
hMenuItem.Profile  =   uimenu('Parent',               hMenu.tps,...
                                    'Label',                '1D Profile',...
                                        'Checked',           'off',...
                                        'Enable',               'off', ...
                                    'Separator',          'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_Profile_Callback);

                                
                                
hMenu.gMap = uimenu('Parent',                 hFig_main,...
                    'HandleVisibility',      'off', ...
                    'Label',                     'Gamma Map', ...
                    'Visible', 'off');
                                            
hMenuItem.gMapAll  =   uimenu('Parent',               hMenu.gMap,...
                                    'Label',                'All',...
                                        'Checked',           'on',...
                                        'Enable',               'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_gMap_Callback);
                                
hMenuItem.gMapFail  =   uimenu('Parent',               hMenu.gMap,...
                                    'Label',                'Fail',...
                                        'Checked',           'off',...
                                        'Enable',               'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_gMap_Callback);

hMenuItem.gMapPass  =   uimenu('Parent',               hMenu.gMap,...
                                    'Label',                'Pass',...
                                        'Checked',           'off',...
                                        'Enable',               'on', ...
                                    'HandleVisibility', 'callback', ...
                                    'Callback',            @hMenuItem_gMap_Callback);
                                
                                