function [  ] = audioFilePresentation( filename )
file = toolkit.File(filename);
properties = toolkit.AudioFileProperties(file.signal);
plot(file.signal)
axis([0 inf -2 2])
file
properties
end

