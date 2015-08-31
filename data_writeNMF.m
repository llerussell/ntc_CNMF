function data_writeNMF( Datawrite, weigh_image, A, Ain, C, Cin, b, f, signal_raw, signal_filtered, signal_inferred, Y_fres, use_merged )
% data_write_NMF( Datawrite, A, Ain, C, Cin, b, f, signal_raw, signal_filtered, signal_inferred )
% Quick function to allow saving of cNMF output parameters and traces into a unique file name and structure to allow for "easy" reloading into matlab.
% Written by Darcy S. Peterka

timestamp = datestr(now, 'YYYYmmDD_HHMMSS');

tmpstruct.datawrite       = Datawrite;
tmpstruct.A               = A;
tmpstruct.Ain             = Ain;
tmpstruct.C               = C;
tmpstruct.Cin             = Cin;
tmpstruct.b               = b;
tmpstruct.f               = f;
tmpstruct.signal_raw      = signal_raw;
tmpstruct.signal_filtered = signal_filtered;
tmpstruct.signal_inferred = signal_inferred;
tmpstruct.weigh_image     = weigh_image;
tmpstruct.Y_fres          = Y_fres;

[~, movieFileName, ~] = fileparts(tmpstruct.datawrite.movieFileName);

if use_merged == 0;
    tmpjnk      = strcat(movieFileName, '_merged_')
    savedstruct = strcat(tmpjnk, timestamp);
    savedfile   = strcat(tmpjnk, '_merged_', timestamp, '_cNMF.mat');
else
    savedstruct = strcat(movieFileName, '_', timestamp);
    savedfile   = strcat(movieFileName, '_', timestamp, '_cNMF.mat');
end

vtmp = genvarname(savedstruct);
eval([vtmp ' = tmpstruct;']);
save(savedfile, vtmp);

disp(['Wrote out file ', [savedfile], ' to disk']);
